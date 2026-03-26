import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

import 'package:pool_solution/presentation/screens/home/home_screen.dart';
import 'package:pool_solution/presentation/screens/configuration/configuration_screen.dart';
import 'package:pool_solution/presentation/providers/theme_provider.dart';
import 'package:pool_solution/presentation/providers/locale_provider.dart';
import 'package:pool_solution/core/theme/app_theme.dart';

// Definimos el router fuera del build para que sea persistente y no se reinicie la navegación
final _routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/configuration',
        builder: (context, state) => const ConfigurationScreen(),
      ),
    ],
  );
});

class PoolSolverApp extends ConsumerWidget {
  const PoolSolverApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final router = ref.watch(_routerProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
    );
  }
}
