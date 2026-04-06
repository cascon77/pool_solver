import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pool_solution/core/widgets/common/problem_card.dart';
import 'package:pool_solution/domain/entities/problem_entity.dart';
import 'package:pool_solution/presentation/providers/locale_provider.dart';
import 'package:pool_solution/presentation/providers/problem_provider.dart';
import 'package:pool_solution/routes/routes.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class ProblemCategoryListScreen extends ConsumerWidget {
  const ProblemCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final problemsAsync = ref.watch(problemsProvider(locale.languageCode));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.problems),
        centerTitle: true,
      ),
      body: problemsAsync.when(
        data: (problems) {
          if (problems.isEmpty) {
            // Si no hay datos reales en la BD aún, mostramos ejemplos manuales
            final mockProblems = _getMockProblems(locale.languageCode);
            return _buildProblemList(mockProblems, context);
          }
          return _buildProblemList(problems, context);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildProblemList(List<ProblemEntity> problems, BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: problems.length,
      itemBuilder: (context, index) {
        final problem = problems[index];
        return ProblemCard(
          problem: problem,
          onTap: () {
            context.pushNamed(Routes.problemDetail, extra: problem);
          },
        );
      },
    );
  }

  List<ProblemEntity> _getMockProblems(String lang) {
    if (lang == 'es') {
      return [
        ProblemEntity(id: 'agua-verde', name: 'Agua Verde (Algas)', description: 'El agua tiene un tono verdoso o las paredes están resbaladizas.'),
        ProblemEntity(id: 'agua-turbia', name: 'Agua Turbia', description: 'El agua se ve blanquecina o con falta de transparencia.'),
        ProblemEntity(id: 'irritacion-ojos', name: 'Irritación de ojos/piel', description: 'Niveles incorrectos de pH o exceso de cloraminas.'),
      ];
    } else {
      return [
        ProblemEntity(id: 'agua-verde', name: 'Green Water (Algae)', description: 'The water has a greenish tint or slippery walls.'),
        ProblemEntity(id: 'agua-turbia', name: 'Cloudy Water', description: 'The water looks whitish or lacks transparency.'),
        ProblemEntity(id: 'irritacion-ojos', name: 'Eye/Skin Irritation', description: 'Incorrect pH levels or excess chloramines.'),
      ];
    }
  }
}
