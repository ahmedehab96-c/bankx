import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/network_bound_resource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';
import '../datasources/settings_remote_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required SettingsLocalDataSource local,
    required SettingsRemoteDataSource remote,
    required NetworkInfo networkInfo,
  }) : _local = local,
       _remote = remote,
       _networkInfo = networkInfo,
       _remoteResource = RemoteResource(networkInfo: networkInfo);

  final SettingsLocalDataSource _local;
  final SettingsRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final RemoteResource _remoteResource;

  @override
  ResultFuture<SettingsBundle> getSettings() => NetworkBoundResource(
    networkInfo: _networkInfo,
    fetchRemote: () async {
      final dto = await _remote.fetchSettings();
      final bundle = SettingsBundle(
        themeMode: _parseTheme(dto.themeMode),
        locale: Locale(dto.locale),
      );
      await _local.saveThemeMode(bundle.themeMode);
      await _local.saveLocale(bundle.locale);
      return bundle;
    },
    fetchLocal: () async {
      final theme = await _local.getCachedThemeMode();
      final locale = await _local.getCachedLocale();
      if (theme == null || locale == null) return null;
      return SettingsBundle(themeMode: theme, locale: locale);
    },
    saveLocal: (_) async {},
  ).execute();

  @override
  ResultFuture<ThemeMode> getThemeMode() async {
    final result = await getSettings();
    return result.fold(
      (failure) => Left(failure),
      (bundle) => Right(bundle.themeMode),
    );
  }

  @override
  ResultFuture<Locale> getLocale() async {
    final result = await getSettings();
    return result.fold(
      (failure) => Left(failure),
      (bundle) => Right(bundle.locale),
    );
  }

  @override
  ResultFuture<void> setThemeMode(ThemeMode mode) =>
      _remoteResource.executeVoid(() async {
        await _local.saveThemeMode(mode);
        await _remote.syncThemeMode(mode);
      });

  @override
  ResultFuture<void> setLocale(Locale locale) =>
      _remoteResource.executeVoid(() async {
        await _local.saveLocale(locale);
        await _remote.syncLocale(locale);
      });

  static ThemeMode _parseTheme(String value) => switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
