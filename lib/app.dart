import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class LoteriasApp extends StatelessWidget {
  const LoteriasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Loterías Internacionales',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
