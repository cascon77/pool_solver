import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/repository_interfaces/problem_repository.dart';

/// Repositorio que lee los problemas desde assets/data/problems.json.
///
/// Estructura del JSON:
/// 1. Problema simple:
///    { "chloramines": { "es": { "description": "...", "procedure": [...] } } }
///
/// 2. Problema con niveles de severidad:
///    { "green_water": { "low": { "es": { "procedure": [...] } }, ... } }
///
/// "general_rules" no es un problema navegable y se excluye de getProblems().
class ProblemRepositoryImpl implements ProblemRepository {
  static const _leveledProblems = {'green_water'};
  static const _excluded = {'general_rules'};

  static const _names = {
    'chloramines':  {'es': 'Cloraminas',       'en': 'Chloramines'},
    'green_water':  {'es': 'Agua verde',        'en': 'Green water'},
    'whitish_water':{'es': 'Agua blanquecina',  'en': 'Whitish water'},
    'scale':        {'es': 'Sarro',             'en': 'Scale'},
    'ph_high':      {'es': 'pH alto',           'en': 'High pH'},
  };

  Map<String, dynamic>? _cache;

  Future<Map<String, dynamic>> _loadJson() async {
    _cache ??= json.decode(
      await rootBundle.loadString('assets/data/problems.json'),
    ) as Map<String, dynamic>;
    return _cache!;
  }

  Map<String, dynamic>? _langBlock(
    Map<String, dynamic> problemBlock,
    String languageCode, {
    String? level,
  }) {
    if (level != null) {
      final levelBlock = problemBlock[level] as Map<String, dynamic>?;
      return levelBlock?[languageCode] as Map<String, dynamic>?;
    }
    return problemBlock[languageCode] as Map<String, dynamic>?;
  }

  List<ProblemStepEntity> _parseSteps(
    List<dynamic> rawSteps,
    String problemId,
    String languageCode, {
    String? level,
  }) {
    return rawSteps.asMap().entries.map((entry) {
      final raw = entry.value as Map<String, dynamic>;
      final stepOrder = raw['step'] as int? ?? (entry.key + 1);
      final stepId = level != null
          ? '$problemId:$level:$stepOrder'
          : '$problemId:$stepOrder';
      return ProblemStepEntity(
        id: stepId,
        problemId: problemId,
        stepOrder: stepOrder,
        title: raw['title'] as String?,
        description: raw['explication'] as String?,
        languageCode: languageCode,
        requiresCalculation: _stepRequiresCalc(problemId, stepOrder),
      );
    }).toList();
  }

  bool _stepRequiresCalc(String problemId, int step) {
    // Paso 3 de cloraminas requiere cálculo (×10)
    return problemId == 'chloramines' && step == 3;
  }

  @override
  Future<List<ProblemEntity>> getProblems(String languageCode) async {
    final data = await _loadJson();
    final problems = <ProblemEntity>[];

    for (final entry in data.entries) {
      final id = entry.key;
      if (_excluded.contains(id)) continue;

      final block = entry.value as Map<String, dynamic>;

      if (_leveledProblems.contains(id)) {
        final firstLevel = block.keys.first;
        final langData = _langBlock(block, languageCode, level: firstLevel);
        problems.add(ProblemEntity(
          id: id,
          name: _names[id]?[languageCode] ?? id,
          description: langData?['description'] as String?,
          languageCode: languageCode,
        ));
      } else {
        final langData = _langBlock(block, languageCode);
        if (langData == null) continue;
        problems.add(ProblemEntity(
          id: id,
          name: _names[id]?[languageCode] ?? id,
          description: langData['description'] as String?,
          languageCode: languageCode,
        ));
      }
    }

    return problems;
  }

  @override
  Future<ProblemEntity?> getProblemById(
      String id, String languageCode) async {
    final data = await _loadJson();
    final block = data[id] as Map<String, dynamic>?;
    if (block == null) return null;

    Map<String, dynamic>? langData;
    if (_leveledProblems.contains(id)) {
      final firstLevel = block.keys.first;
      langData = _langBlock(block, languageCode, level: firstLevel);
    } else {
      langData = _langBlock(block, languageCode);
    }

    return ProblemEntity(
      id: id,
      name: _names[id]?[languageCode] ?? id,
      description: langData?['description'] as String?,
      languageCode: languageCode,
    );
  }

  @override
  Future<List<ProblemStepEntity>> getProblemSteps(
    String problemId,
    String languageCode, {
    String? level,
  }) async {
    final data = await _loadJson();
    final block = data[problemId] as Map<String, dynamic>?;
    if (block == null) return [];

    final langData = _langBlock(block, languageCode, level: level);
    if (langData == null) return [];

    final rawSteps =
        (langData['procedure'] ?? langData['steps']) as List?;
    if (rawSteps == null) return [];

    return _parseSteps(rawSteps, problemId, languageCode, level: level);
  }
}
