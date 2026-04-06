import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/core/theme/theme.dart';
import 'package:pool_solution/domain/entities/problem_entity.dart';
import 'package:pool_solution/presentation/providers/locale_provider.dart';
import 'package:pool_solution/presentation/providers/problem_json_provider.dart';

class ProblemDetailScreen extends ConsumerStatefulWidget {
  final ProblemEntity problem;

  const ProblemDetailScreen({
    super.key,
    required this.problem,
  });

  @override
  ConsumerState<ProblemDetailScreen> createState() => _ProblemDetailScreenState();
}

class _ProblemDetailScreenState extends ConsumerState<ProblemDetailScreen> {
  String selectedLevel = 'medium'; // Nivel por defecto para problemas con niveles

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final locale = ref.watch(localeProvider);
    final jsonAsync = ref.watch(problemsJsonProvider(locale.languageCode));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.problem.name ?? ''),
      ),
      body: SafeArea(
        child: jsonAsync.when(
          data: (data) {
            final problemData = data[widget.problem.id];
            if (problemData == null) return const Center(child: Text('No data found'));

            dynamic langData;
            bool hasLevels = problemData.containsKey('low') || problemData.containsKey('medium') || problemData.containsKey('severe');

            if (hasLevels) {
              langData = problemData[selectedLevel][locale.languageCode];
            } else {
              langData = problemData[locale.languageCode];
            }

            final List<dynamic> procedure = langData['procedure'] ?? [];

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              itemCount: procedure.length + (hasLevels ? 3 : 2), 
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildHeader(
                    isDark, 
                    widget.problem.name ?? '', 
                    langData['description'] ?? widget.problem.description ?? ''
                  );
                }
                
                int currentIndex = 1;

                if (hasLevels) {
                  if (index == 1) {
                    return _buildLevelSelector();
                  }
                  currentIndex = 2;
                }

                if (index == currentIndex) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Pasos a seguir:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                final stepData = procedure[index - (currentIndex + 1)];
                return _buildStepItem(
                  stepData['step'],
                  stepData['title'],
                  stepData['explication'],
                  context,
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }

  Widget _buildLevelSelector() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SegmentedButton<String>(
        segments: const [
          ButtonSegment(value: 'low', label: Text('Leve')),
          ButtonSegment(value: 'medium', label: Text('Medio')),
          ButtonSegment(value: 'severe', label: Text('Grave')),
        ],
        selected: {selectedLevel},
        onSelectionChanged: (newSelection) {
          setState(() {
            selectedLevel = newSelection.first;
          });
        },
      ),
    );
  }

  Widget _buildHeader(bool isDark, String name, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white70 : AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStepItem(int number, String title, String description, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.primaryAccent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.white70 : AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
