import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../features/settings/presentation/bloc/settings_state.dart';

/// Narrow slice of [SettingsState] used to rebuild the app shell.
class AppAppearance extends Equatable {
  const AppAppearance({
    required this.themeMode,
    required this.locale,
    required this.textScale,
    required this.highContrast,
    required this.screenReaderEnabled,
  });

  factory AppAppearance.from(SettingsState state) => AppAppearance(
    themeMode: state.themeMode,
    locale: state.locale,
    textScale: state.textScale,
    highContrast: state.highContrast,
    screenReaderEnabled: state.screenReaderEnabled,
  );

  final ThemeMode themeMode;
  final Locale locale;
  final double textScale;
  final bool highContrast;
  final bool screenReaderEnabled;

  @override
  List<Object?> get props => [
    themeMode,
    locale,
    textScale,
    highContrast,
    screenReaderEnabled,
  ];
}
