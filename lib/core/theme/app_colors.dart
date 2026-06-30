import 'package:flutter/material.dart';

/// BankX brand color palette — premium fintech aesthetic.
abstract final class AppColors {
  // Primary gradient blues
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color primaryDark = Color(0xFF003366);
  static const Color accentCyan = Color(0xFF5AC8FA);

  // Dark theme backgrounds
  static const Color darkBackground = Color(0xFF0A0E21);
  static const Color darkSurface = Color(0xFF141B2D);
  static const Color darkCard = Color(0xFF1A2332);

  // Light theme backgrounds
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);

  // Semantic colors
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);
  static const Color income = Color(0xFF34C759);
  static const Color expense = Color(0xFFFF3B30);

  // Text
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF8E8E93);
  static const Color textPrimaryLight = Color(0xFF1C1C1E);
  static const Color textSecondaryLight = Color(0xFF636366);

  /// Primary brand gradient used on buttons, cards, and accents.
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentCyan, primaryBlue, primaryDark],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E3A5F), Color(0xFF0A1628)],
  );

  static const LinearGradient promoGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF007AFF), Color(0xFF5856D6)],
  );
}
