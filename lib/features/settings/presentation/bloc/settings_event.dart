import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsLoaded extends SettingsEvent {
  const SettingsLoaded();
}

class ThemeChanged extends SettingsEvent {
  const ThemeChanged(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}

class LocaleChanged extends SettingsEvent {
  const LocaleChanged(this.locale);

  final Locale locale;

  @override
  List<Object?> get props => [locale];
}

class ThemeToggled extends SettingsEvent {
  const ThemeToggled();
}
