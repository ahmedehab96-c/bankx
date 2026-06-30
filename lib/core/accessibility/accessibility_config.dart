import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Accessibility preferences applied app-wide via [SettingsBloc].
class AccessibilityConfig extends Equatable {
  const AccessibilityConfig({
    this.textScale = 1.0,
    this.highContrast = false,
    this.screenReaderEnabled = false,
  });

  final double textScale;
  final bool highContrast;
  final bool screenReaderEnabled;

  AccessibilityConfig copyWith({
    double? textScale,
    bool? highContrast,
    bool? screenReaderEnabled,
  }) {
    return AccessibilityConfig(
      textScale: textScale ?? this.textScale,
      highContrast: highContrast ?? this.highContrast,
      screenReaderEnabled: screenReaderEnabled ?? this.screenReaderEnabled,
    );
  }

  @override
  List<Object?> get props => [textScale, highContrast, screenReaderEnabled];
}

/// Applies large fonts and semantics hints without changing page layouts.
class AccessibilityWrapper extends StatelessWidget {
  const AccessibilityWrapper({
    super.key,
    required this.config,
    required this.child,
  });

  final AccessibilityConfig config;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(config.textScale.clamp(0.8, 2.0)),
        boldText: config.highContrast,
        accessibleNavigation: config.screenReaderEnabled,
      ),
      child: Semantics(
        label: config.screenReaderEnabled ? 'BankX accessible mode' : null,
        child: child,
      ),
    );
  }
}
