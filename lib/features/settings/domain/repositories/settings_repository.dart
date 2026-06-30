import 'package:flutter/material.dart';

import '../../../../core/utils/result.dart';

abstract class SettingsRepository {
  ResultFuture<SettingsBundle> getSettings();
  ResultFuture<ThemeMode> getThemeMode();
  ResultFuture<Locale> getLocale();
  ResultFuture<void> setThemeMode(ThemeMode mode);
  ResultFuture<void> setLocale(Locale locale);
}

class SettingsBundle {
  const SettingsBundle({required this.themeMode, required this.locale});

  final ThemeMode themeMode;
  final Locale locale;
}
