import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Responsive layout helpers for phone and tablet.
abstract final class Responsive {
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600;

  static double horizontalPadding(BuildContext context) =>
      isTablet(context) ? 32 : 20;

  static int gridCrossAxisCount(BuildContext context) =>
      isTablet(context) ? 4 : 2;

  static double maxContentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return isTablet(context) ? width * 0.7 : width;
  }
}

/// Currency and date formatting utilities.
abstract final class AppFormatters {
  static String currency(double amount, {String symbol = 'AED'}) {
    final formatter = NumberFormat('#,##0.00');
    return '$symbol ${formatter.format(amount)}';
  }

  static String compactCurrency(double amount, {String symbol = 'AED'}) {
    if (amount >= 1000000) {
      return '$symbol ${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return '$symbol ${(amount / 1000).toStringAsFixed(1)}K';
    }
    return currency(amount, symbol: symbol);
  }

  static String dateTime(DateTime date) =>
      DateFormat('MMM dd, yyyy • hh:mm a').format(date);

  static String date(DateTime date) => DateFormat('MMM dd, yyyy').format(date);

  static String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays}d ago';
  }
}
