import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/presentation/providers/shared_prefs_provider.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier(ref);
});

class LocaleNotifier extends StateNotifier<Locale> {
  final Ref _ref;
  static const _key = 'language_code';

  LocaleNotifier(this._ref) : super(const Locale('es')) {
    _loadLocale();
  }

  void _loadLocale() {
    final prefs = _ref.read(sharedPreferencesProvider);
    final languageCode = prefs.getString(_key);
    if (languageCode != null) {
      state = Locale(languageCode);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = _ref.read(sharedPreferencesProvider);
    await prefs.setString(_key, locale.languageCode);
  }
}
