import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Scaffold compartido por las secciones principales (Home, Sorteos,
/// Noticias), con una barra de navegación inferior.
///
/// Usa `StatefulShellRoute` de go_router (ver app_router.dart), lo que
/// mantiene el estado/scroll de cada pestaña al cambiar entre ellas.
///
/// NOTA: cuando se agregue el perfil de usuario (ver PLAN.md → Fase 3),
/// solo hay que sumar un `NavigationDestination` aquí y su rama en el
/// router; el resto del layout no cambia.
class MainScaffold extends StatelessWidget {
  const MainScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          // goBranch con initialLocation: true vuelve a la raíz de la
          // pestaña si el usuario toca de nuevo la que ya está activa.
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.casino_outlined), selectedIcon: Icon(Icons.casino), label: 'Sorteos'),
          NavigationDestination(icon: Icon(Icons.newspaper_outlined), selectedIcon: Icon(Icons.newspaper), label: 'Noticias'),
          // Próximo (Fase 3): NavigationDestination(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }
}
