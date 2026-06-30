import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../shared/bloc/request_status.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.status = RequestStatus.initial,
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('en'),
    this.textScale = 1.0,
    this.highContrast = false,
    this.screenReaderEnabled = false,
    this.errorMessage,
  });

  final RequestStatus status;
  final ThemeMode themeMode;
  final Locale locale;
  final double textScale;
  final bool highContrast;
  final bool screenReaderEnabled;
  final String? errorMessage;

  SettingsState copyWith({
    RequestStatus? status,
    ThemeMode? themeMode,
    Locale? locale,
    double? textScale,
    bool? highContrast,
    bool? screenReaderEnabled,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SettingsState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      textScale: textScale ?? this.textScale,
      highContrast: highContrast ?? this.highContrast,
      screenReaderEnabled: screenReaderEnabled ?? this.screenReaderEnabled,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    themeMode,
    locale,
    textScale,
    highContrast,
    screenReaderEnabled,
    errorMessage,
  ];
}
