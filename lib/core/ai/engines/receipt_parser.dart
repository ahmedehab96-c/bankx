import '../models/ai_models.dart';

/// Receipt text parser — ready for ML Kit OCR integration.
class ReceiptParser {
  const ReceiptParser();

  ParsedReceipt parse(String rawText) {
    final lines = rawText
        .split('\n')
        .where((l) => l.trim().isNotEmpty)
        .toList();
    final merchant = _extractMerchant(lines);
    final amount = _extractAmount(rawText);
    final date = _extractDate(rawText);
    final category = _categorize(merchant, rawText);

    return ParsedReceipt(
      merchantName: merchant,
      amount: amount,
      date: date,
      category: category,
      rawText: rawText,
      confidence: amount > 0 ? 0.85 : 0.5,
    );
  }

  String _extractMerchant(List<String> lines) {
    if (lines.isEmpty) return 'Unknown Merchant';
    return lines.first.trim();
  }

  double _extractAmount(String text) {
    final patterns = [
      RegExp(
        r'(?:total|amount|aed|usd)\s*:?\s*([\d,]+\.?\d*)',
        caseSensitive: false,
      ),
      RegExp(r'([\d,]+\.\d{2})\s*(?:aed|usd|eur)', caseSensitive: false),
      RegExp(r'\b(\d+\.\d{2})\b'),
    ];
    for (final p in patterns) {
      final match = p.firstMatch(text);
      if (match != null) {
        final cleaned = match.group(1)?.replaceAll(',', '') ?? '';
        return double.tryParse(cleaned) ?? 0;
      }
    }
    return 0;
  }

  DateTime _extractDate(String text) {
    final datePattern = RegExp(r'(\d{1,2})[/.-](\d{1,2})[/.-](\d{2,4})');
    final match = datePattern.firstMatch(text);
    if (match != null) {
      final d = int.tryParse(match.group(1) ?? '') ?? 1;
      final m = int.tryParse(match.group(2) ?? '') ?? 1;
      var y = int.tryParse(match.group(3) ?? '') ?? DateTime.now().year;
      if (y < 100) y += 2000;
      return DateTime(y, m, d);
    }
    return DateTime.now();
  }

  String _categorize(String merchant, String text) {
    final lower = '${merchant.toLowerCase()} ${text.toLowerCase()}';
    if (lower.contains('restaurant') ||
        lower.contains('cafe') ||
        lower.contains('food')) {
      return 'food';
    }
    if (lower.contains('taxi') ||
        lower.contains('uber') ||
        lower.contains('fuel')) {
      return 'transport';
    }
    if (lower.contains('market') ||
        lower.contains('store') ||
        lower.contains('mall')) {
      return 'shopping';
    }
    return 'other';
  }
}
