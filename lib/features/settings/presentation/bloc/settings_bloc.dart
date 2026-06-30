import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/settings_usecases.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required GetSettingsUseCase getSettingsUseCase,
    required SetThemeModeUseCase setThemeModeUseCase,
    required SetLocaleUseCase setLocaleUseCase,
  })  : _getSettingsUseCase = getSettingsUseCase,
        _setThemeModeUseCase = setThemeModeUseCase,
        _setLocaleUseCase = setLocaleUseCase,
        super(const SettingsState()) {
    on<SettingsLoaded>(_onSettingsLoaded);
    on<ThemeChanged>(_onThemeChanged);
    on<LocaleChanged>(_onLocaleChanged);
    on<ThemeToggled>(_onThemeToggled);
  }

  final GetSettingsUseCase _getSettingsUseCase;
  final SetThemeModeUseCase _setThemeModeUseCase;
  final SetLocaleUseCase _setLocaleUseCase;

  Future<void> _onSettingsLoaded(
    SettingsLoaded event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearError: true));
    final result = await _getSettingsUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (settings) => emit(
        state.copyWith(
          status: RequestStatus.success,
          themeMode: settings.themeMode,
          locale: settings.locale,
        ),
      ),
    );
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearError: true));
    final result = await _setThemeModeUseCase(SetThemeModeParams(event.themeMode));
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: RequestStatus.success,
          themeMode: event.themeMode,
        ),
      ),
    );
  }

  Future<void> _onLocaleChanged(
    LocaleChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearError: true));
    final result = await _setLocaleUseCase(SetLocaleParams(event.locale));
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: RequestStatus.success,
          locale: event.locale,
        ),
      ),
    );
  }

  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<SettingsState> emit,
  ) async {
    final nextMode = switch (state.themeMode) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light,
    };
    add(ThemeChanged(nextMode));
  }
}
