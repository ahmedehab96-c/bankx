import 'package:flutter/material.dart';

import '../../../../core/network/dio_exception_helper.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/api/banking_api_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import 'settings_remote_data_source.dart';

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  SettingsRemoteDataSourceImpl(this._api, this._cache);

  final BankingApiService _api;
  final CacheStorageService _cache;

  @override
  Future<SettingsDto> fetchSettings() async {
    try {
      final dto = await _api.getSettings();
      await _cache.write(CacheKeys.settings, dto.toJson());
      return dto;
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<void> syncThemeMode(ThemeMode mode) async {
    try {
      final current = await _readOrDefault();
      await _api.updateSettings(
        current.copyWith(themeMode: _themeToString(mode)),
      );
      await _cache.write(
        CacheKeys.settings,
        current.copyWith(themeMode: _themeToString(mode)).toJson(),
      );
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<void> syncLocale(Locale locale) async {
    try {
      final current = await _readOrDefault();
      await _api.updateSettings(current.copyWith(locale: locale.languageCode));
      await _cache.write(
        CacheKeys.settings,
        current.copyWith(locale: locale.languageCode).toJson(),
      );
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  Future<SettingsDto> _readOrDefault() async {
    final cached = await _cache.read(CacheKeys.settings);
    if (cached != null) return SettingsDto.fromJson(cached);
    return const SettingsDto(themeMode: 'system', locale: 'en');
  }

  static String _themeToString(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  };
}
