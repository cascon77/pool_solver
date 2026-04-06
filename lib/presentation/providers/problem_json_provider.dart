import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/domain/entities/problem_entity.dart';

final problemsJsonProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, languageCode) async {
  final String response = await rootBundle.loadString('assets/data/problems.json');
  final data = await json.decode(response);
  return data as Map<String, dynamic>;
});

final problemsListProvider = FutureProvider.family<List<ProblemEntity>, String>((ref, languageCode) async {
  final data = await ref.watch(problemsJsonProvider(languageCode).future);
  
  List<ProblemEntity> problems = [];
  
  data.forEach((key, value) {
    if (key == 'general_rules') return;
    
    // Si tiene niveles (como green_water)
    if (value.containsKey('low') || value.containsKey('medium') || value.containsKey('severe')) {
      // Para la lista general, mostramos el problema base o podrías desglosarlos
      // Por simplicidad, añadimos el problema base con una descripción general
      final langData = value['medium']?[languageCode] ?? value['low']?[languageCode];
      problems.add(ProblemEntity(
        id: key,
        name: key == 'green_water' ? (languageCode == 'es' ? 'Agua Verde' : 'Green Water') : key,
        description: languageCode == 'es' ? 'Problemas de algas en diferentes niveles.' : 'Algae problems in different levels.',
      ));
    } else if (value.containsKey(languageCode)) {
      final langData = value[languageCode];
      problems.add(ProblemEntity(
        id: key,
        name: key.replaceAll('_', ' ').toUpperCase(), // Ajustar según convenga
        description: langData['description'] ?? '',
      ));
    }
  });
  
  return problems;
});
