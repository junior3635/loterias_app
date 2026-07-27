# PLAN.md — App de Resultados de Loterías Internacionales

> Este archivo es la "memoria" del proyecto. Cada vez que retomemos el trabajo
> (en esta conversación o subiendo este archivo en una nueva), léelo primero
> para tener contexto completo de decisiones tomadas y próximos pasos.
> Última actualización: 22 julio 2026.

## 1. Objetivo del proyecto

App Flutter multiplataforma (Android/iOS, con soporte para web/desktop a
futuro) que muestra resultados de loterías internacionales, empezando por
**Estados Unidos** (Powerball, Mega Millions, loterías estatales) y
expandiéndose luego a otros países (España/ONCE, México, etc.).

## 2. Decisiones de arquitectura (por qué)

| Decisión | Elegido | Alternativas consideradas | Razón |
|---|---|---|---|
| Gestión de estado | **Riverpod 2.x** | Bloc, Provider, GetX | Recomendado como estándar 2026 para proyectos nuevos medianos/grandes: sin `BuildContext`, seguro en compilación, buen testing, menos boilerplate que Bloc. |
| Routing | **go_router** | Navigator 2.0 manual | Es el paquete de routing declarativo recomendado oficialmente por el equipo de Flutter. |
| Arquitectura de capas | **Clean Architecture simplificada** (`domain` / `data` / `presentation`) por feature | MVC, MVVM plano | Separa reglas de negocio de la fuente de datos; facilita cambiar de API sin tocar UI. |
| Organización | **Feature-first** (`lib/features/lotteries/...`) | Layer-first (`lib/screens`, `lib/models`...) | Escala mejor cuando se agreguen más países/features (favoritos, notificaciones, etc.). |
| Modelos inmutables | **Freezed + json_serializable** | Clases manuales | Menos errores, `copyWith`/`==` gratis, generación de `fromJson`. |
| HTTP | **Dio** | http | Interceptores, timeouts y manejo de errores más robusto. |
| Lints | **flutter_lints** (oficial) | ninguno / paquetes de terceros | Estándar recomendado por Flutter. |

## 3. Estructura de carpetas creada

```
loterias_app/
├── pubspec.yaml
├── analysis_options.yaml
├── PLAN.md                     ← este archivo
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── core/
│   │   ├── router/app_router.dart      (StatefulShellRoute: 3 pestañas)
│   │   ├── theme/app_theme.dart
│   │   ├── network/dio_client.dart
│   │   ├── constants/                    (vacío, próximo paso)
│   │   └── utils/                        (vacío, próximo paso)
│   ├── shared/
│   │   └── widgets/main_scaffold.dart   (bottom nav bar de las 3 secciones)
│   └── features/
│       ├── home/                         ← Sección 1: HOME (dashboard)
│       │   └── presentation/screens/home_screen.dart
│       │       (combina resultados recientes + noticias destacadas)
│       ├── lotteries/                    ← dominio/datos compartidos de resultados
│       │   ├── domain/
│       │   │   ├── entities/lottery_result.dart
│       │   │   ├── repositories/lottery_repository.dart   (interfaz)
│       │   │   └── usecases/                                (vacío, próximo paso)
│       │   ├── data/
│       │   │   ├── models/lottery_result_model.dart          (DTO)
│       │   │   ├── datasources/lottery_remote_datasource.dart (pendiente API real)
│       │   │   └── repositories/lottery_repository_impl.dart  (MOCK, 6 resultados EE. UU.)
│       │   └── presentation/
│       │       ├── providers/lottery_providers.dart  (repositorio, latest, all)
│       │       └── widgets/lottery_result_card.dart
│       ├── draws/                        ← Sección 2: SORTEOS (filtros país/estado)
│       │   └── presentation/
│       │       ├── providers/draws_providers.dart   (filtros + resultados filtrados)
│       │       ├── widgets/draws_filter_bar.dart     (dropdowns país/estado)
│       │       └── screens/draws_screen.dart
│       └── news/                         ← Sección 3: NOTICIAS
│           ├── domain/entities/news_article.dart
│           ├── data/repositories/news_repository_impl.dart  (MOCK)
│           └── presentation/
│               ├── providers/news_providers.dart
│               ├── widgets/news_card.dart
│               └── screens/news_screen.dart
└── test/
```

### Selector de estados ("State lotteries")

Se agregó, dentro de `features/draws`, un selector de estado a pantalla
completa inspirado en un patrón visual de referencia (lista en 2
columnas, código + nombre, ordenada alfabéticamente por nombre):

- `core/constants/us_states.dart` — los 50 estados + D.C. (código +
  nombre completo), reutilizable en cualquier parte de la app.
- `features/draws/presentation/widgets/us_states_list.dart` —
  `UsStatesList`: widget genérico de 2 columnas con divisores, recibe
  la lista a mostrar y un callback `onStateSelected`. No depende de
  Riverpod ni de rutas, así que también sirve para otros usos futuros
  (ej. un selector dentro de "Perfil" para guardar el estado favorito).
- `features/draws/presentation/screens/state_picker_screen.dart` —
  pantalla `/draws/states` con buscador + `UsStatesList`. Al tocar un
  estado, actualiza `selectedStateProvider` y vuelve a Sorteos, que
  queda filtrado automáticamente.
- Se accede desde el ícono de lista en el AppBar de la pantalla de
  Sorteos. La ruta está anidada con `parentNavigatorKey` sobre el
  navigator raíz para que se abra a pantalla completa (tapando el
  bottom nav), que es el comportamiento esperado en un picker.

### Selector de país + Home reorganizado en 3 secciones

A pedido explícito, Home ahora funciona así:

1. **AppBar con selector de país** (`shared/widgets/country_selector_button.dart`):
   botón con bandera + código que abre un bottom sheet con
   `kSupportedCountries` (`core/constants/countries.dart`). Hoy solo
   **Estados Unidos** está `available: true`; México, España y
   Argentina aparecen como "Próximamente" — la estructura ya está
   lista para sumarlos sin rediseñar nada (ver Fase 5).
2. **"Loterías principales"** — usa el nuevo
   `featuredLotteriesProvider` (`lottery_providers.dart`): resultados
   del país seleccionado SIN estado asignado (`state == null`), que en
   EE. UU. da Powerball y Mega Millions. Si un país nuevo sigue esta
   misma convención (loterías nacionales sin `state`), aparecen acá
   automáticamente.
3. **"Loterías por estado"** — reutiliza `UsStatesList` (ahora con
   `shrinkWrap`/`physics` para incrustarse dentro del scroll de Home)
   mostrando solo los estados que tienen resultados reales
   (`statesWithLotteriesProvider`), + botón "Ver todos los estados"
   que lleva al picker completo (`/draws/states`). Tocar un estado
   guarda el filtro y navega a la pestaña Sorteos ya filtrada.
4. **"Noticias"** — igual que antes.

**Cambio de arquitectura importante:** `selectedCountryProvider` se
movió de `features/draws` a `shared/providers/country_providers.dart`,
porque ahora es un estado verdaderamente compartido entre Home y
Sorteos (antes vivía solo en Sorteos). Si mañana Perfil también
necesita saber el país activo, ya está en el lugar correcto.

### Sobre la navegación

Se usa `StatefulShellRoute.indexedStack` de `go_router` (patrón oficial
recomendado para bottom navigation): cada pestaña (Home / Sorteos /
Noticias) mantiene su propio stack de navegación y estado de scroll al
cambiar entre ellas. El bottom nav vive en `shared/widgets/main_scaffold.dart`.

**Perfil de usuario (futuro):** cuando se implemente, se agrega como una
4ta rama (`StatefulShellBranch`) en `app_router.dart` y un
`NavigationDestination` más en `main_scaffold.dart` — ya quedaron los
comentarios `TODO` marcando exactamente dónde. No requiere reestructurar
nada de lo ya construido.

## 3.1 Bitácora de errores resueltos

| Fecha | Error | Causa | Solución |
|---|---|---|---|
| 22 jul 2026 | `Locale data has not been initialized, call initializeDateFormatting(<locale>)` | `LotteryResultCard` usa `DateFormat('d MMM y', 'es')`, y `intl` requiere inicializar explícitamente los datos de cada locale antes de usarlo. | Se agregó `await initializeDateFormatting('es');` en `main()` (`lib/main.dart`), antes de `runApp`. |

## 4. Estado actual (lo que YA funciona)

- Estructura Clean Architecture + feature-first lista.
- **3 secciones principales con bottom navigation** (`go_router` +
  `StatefulShellRoute`):
  1. **Home** (`/home`) — resumen: últimos 3 resultados de EE. UU. +
     últimas 2 noticias.
  2. **Sorteos** (`/draws`) — lista completa de resultados con filtros
     por país y estado (dropdowns), usando providers derivados de Riverpod.
  3. **Noticias** (`/news`) — listado de noticias/información (mock).
- Datos **mock**: 6 resultados de EE. UU. (Powerball, Mega Millions y
  loterías estatales de Florida, California, Nueva York y Texas) y 3
  noticias, para poder ejecutar y ver todo funcionando ya mismo, sin
  depender de una API externa todavía.
- Tema Material 3 con soporte claro/oscuro.
- Perfil de usuario: **no implementado aún** (a propósito, ver Fase 3),
  pero el router y el bottom nav ya están preparados para sumarlo sin
  refactor.

## 5. Pendiente / Roadmap por fases

### Fase 1 — Puesta en marcha local (SIGUIENTE PASO INMEDIATO)
- [ ] Instalar Flutter SDK (si no lo tienes) → https://docs.flutter.dev/get-started/install
- [ ] Copiar esta carpeta `loterias_app/` a tu máquina.
- [ ] Ejecutar `flutter pub get`
- [ ] Ejecutar generación de código: `dart run build_runner build --delete-conflicting-outputs`
  (necesario porque usamos Freezed/json_serializable)
- [ ] Ejecutar `flutter run`
- [ ] Confirmar que ves la lista mock de resultados.

### Fase 2 — Fuente de datos real (US)
- [ ] Investigar y decidir la fuente de datos para Powerball / Mega Millions:
  - Opción A: API pública de terceros (ej. RapidAPI tiene varias — validar
    confiabilidad, límites y costo).
  - Opción B: Scraping de los sitios oficiales (powerball.com,
    megamillions.com) — requiere backend intermedio (no hacerlo desde el
    cliente por CORS/ToS).
  - Opción C: Backend propio (Cloud Function/Firebase) que centraliza,
    cachea y expone un JSON simple a la app.
- [ ] Implementar `LotteryRemoteDataSourceImpl` real.
- [ ] Implementar `LotteryRepositoryImpl` (reemplazar el Mock) y actualizar
  el binding en `lottery_providers.dart`.
- [ ] Manejar zonas horarias de sorteos (`intl` + `timezone` package).

### Fase 3 — Features adicionales
- [x] **3 secciones principales con bottom navigation**: Home, Sorteos
      (con filtros país/estado), Noticias. *(22 jul 2026)*
- [x] **Selector de país en Home** + reorganización en 3 sub-secciones
      (principales / por estado / noticias), con catálogo de países
      preparado para expansión futura. *(23 jul 2026)*
- [ ] Pantalla de detalle por lotería + historial (`/draws/:lotteryId`).
- [ ] Favoritos (persistidos con `shared_preferences`).
- [ ] **Perfil de usuario** — pendiente a propósito, se decidió más
      adelante. Cuando se aborde: agregar `StatefulShellBranch` en
      `app_router.dart` + `NavigationDestination` en
      `shared/widgets/main_scaffold.dart` (ya están los `TODO` marcados
      en ambos archivos). Definir primero: ¿auth propio o proveedor
      externo (Google/Apple)? ¿qué datos persiste (favoritos, alertas)?
- [ ] Notificaciones push de nuevos resultados (Firebase Cloud Messaging).
- [ ] Comprobador de números ("¿gané?").
- [ ] Detalle de noticia (`/news/:id`) en vez de solo resumen en tarjeta.

### Fase 4 — Calidad y producción
- [ ] Tests unitarios (repositorios, providers) con `mocktail`.
- [ ] Tests de widgets (`HomeScreen`, `LotteryResultCard`).
- [ ] Manejo de errores/crash reporting (ej. Firebase Crashlytics o Sentry).
- [ ] CI (GitHub Actions) con `flutter analyze` + `flutter test`.
- [ ] Internacionalización real con `flutter gen-l10n` (hoy solo `intl`
  para formateo de fechas/moneda).
- [ ] Íconos y splash screen (`flutter_launcher_icons`,
  `flutter_native_splash`).

### Fase 5 — Expansión internacional
- [ ] Agregar loterías de España (ONCE, Primitiva, Euromillones).
- [ ] Agregar loterías de Latinoamérica (México, Argentina, etc.).
- [ ] Multi-idioma (ES/EN mínimo).

## 6. Cómo retomar este proyecto en una nueva conversación

1. Sube este archivo `PLAN.md` (o toda la carpeta `loterias_app/`) a la
   conversación.
2. Dime en qué fase te quedaste o qué quieres hacer ahora.
3. Continuamos desde ahí sin repetir trabajo ya hecho.

> Tip: si activas la función de memoria de Claude (Configuración →
> "Generar memoria del historial de chat"), Claude podrá recordar el
> contexto de este proyecto automáticamente entre conversaciones. Aun así,
> este archivo es la fuente de verdad — mantenlo actualizado.
