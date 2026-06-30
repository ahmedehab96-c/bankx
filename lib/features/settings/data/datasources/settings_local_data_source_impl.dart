import 'package:flutter/material.dart';

import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import 'settings_local_data_source.dart';

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl(this._cache);

  final CacheStorageService _cache;

  static const _default = SettingsDto(themeMode: 'system', locale: 'en');

  @override
  Future<ThemeMode?> getCachedThemeMode() async {
    final dto = await _readDto();
    return dto == null ? null : _parseTheme(dto.themeMode);
  }

  @override
  Future<Locale?> getCachedLocale() async {
    final dto = await _readDto();
    return dto == null ? null : Locale(dto.locale);
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    final current = await _readDto() ?? _default;
    await _cache.write(
      CacheKeys.settings,
      current.copyWith(themeMode: _themeToString(mode)).toJson(),
    );
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    final current = await _readDto() ?? _default;
    await _cache.write(
      CacheKeys.settings,
      current.copyWith(locale: locale.languageCode).toJson(),
    );
  }

  Future<SettingsDto?> _readDto() async {
    final json = await _cache.read(CacheKeys.settings);
    if (json == null) return null;
    return SettingsDto.fromJson(json);
  }

  static ThemeMode _parseTheme(String value) => switch (value) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  static String _themeToString(ThemeMode mode) => switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };
}
