import 'package:go_router/go_router.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/presentation/screens/problems/problem_detail_screen.dart';
import 'package:pool_solution/presentation/screens/screens.dart';


class Routes {
  static const String home = "home";
  static const String tips = "tips";
  static const String configuration = "configuration";
  static const String poolSetup = "pool-setup";
  static const String newPool = "new-pool";
  static const String inventory = "inventory";
  static const String history = "history";
  static const String calculators = "calculators";
  static const String problems = "problems";
  static const String problemDetail = "problem-detail";
  static const String calcPh = "calc-ph";
  static const String calcCl = "calc-cl";
  static const String calcFlocculant = "calc-flocculant";
  static const String calcChloramines = "calc-chloramines";
  static const String calcAlkalinity = "calc-alkalinity";



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
      GoRoute(
        path: '/inventory',
        name: inventory,
        builder: (context, state) {
          final pool = state.extra as PoolEntity;
          return InventoryScreen(pool: pool);
        },
      ),
      GoRoute(
        path: '/history',
        name: history,
        builder: (context, state) {
          final poolId = state.extra as int;
          return HistoryScreen(poolId: poolId);
        },
      ),
      GoRoute(
        path: '/calculators',
        name: calculators,
        builder: (context, state) {
          final pool = state.extra as PoolEntity;
          return CalcListScreen(pool: pool);
        },
      ),
      GoRoute(
        path: '/problems',
        name: problems,
        builder: (context, state) => const ProblemCategoryListScreen(),
      ),
      GoRoute(
        path: '/problems/problem-detail',
        name: problemDetail,
        builder: (context, state) {
          final problem = state.extra as ProblemEntity;
          return ProblemDetailScreen(problem: problem);
        },
      ),
      GoRoute(
        path: '/calculators/ph',
        name: calcPh,
        builder: (context, state) {
          final pool = state.extra as PoolEntity;
          return CalcPhScreen(pool: pool);
        },
      ),
      GoRoute(
        path: '/calculators/cl',
        name: calcCl,
        builder: (context, state) {
          final pool = state.extra as PoolEntity;
          return CalcClScreen(pool: pool);
        },
      ),
      GoRoute(
        path: '/calculators/flocculant',
        name: calcFlocculant,
        builder: (context, state) {
          final pool = state.extra as PoolEntity;
          return CalcFlocculantScreen(pool: pool);
        },
      ),
      GoRoute(
        path: '/calculators/chloramines',
        name: calcChloramines,
        builder: (context, state) {
          final pool = state.extra as PoolEntity;
          return CalcChloraminesScreen(pool: pool);
        },
      ),
      GoRoute(
        path: '/calculators/alkalinity',
        name: calcAlkalinity,
        builder: (context, state) {
          final pool = state.extra as PoolEntity;
          return CalcAlkalinityScreen(pool: pool);
        },
      ),
    ];
  }
}
