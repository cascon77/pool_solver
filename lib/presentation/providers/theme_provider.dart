import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/presentation/providers/shared_prefs_provider.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final Ref _ref;
  static const _key = 'theme_mode';

  ThemeModeNotifier(this._ref) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final prefs = _ref.read(sharedPreferencesProvider);
    final themeIndex = prefs.getInt(_key);
    if (themeIndex != null) {
      state = ThemeMode.values[themeIndex];
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = _ref.read(sharedPreferencesProvider);
    await prefs.setInt(_key, mode.index);
  }
}
