import 'package:flutter/material.dart';

import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase implements UseCase<SettingsBundle, NoParams> {
  GetSettingsUseCase(this._repository);

  final SettingsRepository _repository;

  @override
  ResultFuture<SettingsBundle> call(NoParams params) =>
      _repository.getSettings();
}

class SetThemeModeParams {
  const SetThemeModeParams(this.mode);

  final ThemeMode mode;
}

class SetThemeModeUseCase implements UseCase<void, SetThemeModeParams> {
  SetThemeModeUseCase(this._repository);

  final SettingsRepository _repository;

  @override
  ResultFuture<void> call(SetThemeModeParams params) =>
      _repository.setThemeMode(params.mode);
}

class SetLocaleParams {
  const SetLocaleParams(this.locale);

  final Locale locale;
}

class SetLocaleUseCase implements UseCase<void, SetLocaleParams> {
  SetLocaleUseCase(this._repository);

  final SettingsRepository _repository;

  @override
  ResultFuture<void> call(SetLocaleParams params) =>
      _repository.setLocale(params.locale);
}
