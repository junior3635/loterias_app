import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/draws/presentation/screens/draws_screen.dart';
import '../../features/draws/presentation/screens/state_picker_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/news/presentation/screens/news_screen.dart';
import '../../shared/widgets/main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellHome',
);
final _shellNavigatorDrawsKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellDraws',
);
final _shellNavigatorNewsKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellNews',
);

/// Router con 3 ramas independientes (Home, Sorteos, Noticias) dentro de
/// un `StatefulShellRoute`, que es el patrón recomendado por go_router
/// para bottom navigation: cada pestaña mantiene su propio historial de
/// navegación y su estado de scroll al cambiar entre ellas.
///
/// Cuando se agregue el Perfil de usuario (PLAN.md → Fase 3), se suma
/// una rama más aquí siguiendo el mismo patrón.
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDrawsKey,
          routes: [
            GoRoute(
              path: '/draws',
              name: 'draws',
              builder: (context, state) => const DrawsScreen(),
              routes: [
                GoRoute(
                  path: 'states',
                  name: 'statePicker',
                  // parentNavigatorKey: usa el navigator RAÍZ (no el de la
                  // rama) para que esta pantalla se abra a pantalla
                  // completa, tapando el bottom nav — es el comportamiento
                  // esperado para un selector tipo "picker".
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const StatePickerScreen(),
                ),
              ],
              // Próxima ruta (Fase 3): '/draws/:lotteryId' -> detalle/historial
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorNewsKey,
          routes: [
            GoRoute(
              path: '/news',
              name: 'news',
              builder: (context, state) => const NewsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
