import 'package:go_router/go_router.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/presentation/screens/home/home_screen.dart';
import 'package:pool_solution/presentation/screens/home/new_pool_screen.dart';
import 'package:pool_solution/presentation/screens/configuration/configuration_screen.dart';
import 'package:pool_solution/presentation/screens/tips/tips_screen.dart';
import 'package:pool_solution/presentation/screens/pool_setup/pool_setup_screen.dart';

class Routes {
  static const String home = "home";
  static const String tips = "tips";
  static const String configuration = "configuration";
  static const String poolSetup = "pool-setup";
  static const String newPool = "new-pool";

  static List<GoRoute> getRoutes() {
    return [
      GoRoute(
        path: '/',
        name: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/configuration',
        name: configuration,
        builder: (context, state) => const ConfigurationScreen(),
      ),
      GoRoute(
        path: '/tips',
        name: tips,
        builder: (context, state) => const TipsScreen(),
      ),
      GoRoute(
        path: '/pool-setup',
        name: poolSetup,
        builder: (context, state) {
          final pool = state.extra as PoolEntity;
          return PoolSetupScreen(pool: pool);
        },
      ),
      GoRoute(
        path: '/new-pool',
        name: newPool,
        builder: (context, state) {
          final pool = state.extra as PoolEntity?;
          return NewPoolScreen(pool: pool);
        },
      ),
    ];
  }
}
