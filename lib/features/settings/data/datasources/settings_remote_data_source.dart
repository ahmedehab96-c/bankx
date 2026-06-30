import 'package:flutter/material.dart';

import '../../../../shared/data/dto/banking_dtos.dart';

abstract class SettingsRemoteDataSource {
  Future<SettingsDto> fetchSettings();
  Future<void> syncThemeMode(ThemeMode mode);
  Future<void> syncLocale(Locale locale);
}
