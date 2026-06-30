import 'package:flutter/material.dart';

abstract class SettingsLocalDataSource {
  Future<ThemeMode?> getCachedThemeMode();
  Future<Locale?> getCachedLocale();
  Future<void> saveThemeMode(ThemeMode mode);
  Future<void> saveLocale(Locale locale);
}
