import '../models/ai_models.dart';

/// Parses voice commands in English and Arabic.
class VoiceCommandParser {
  const VoiceCommandParser();

  VoiceCommand parse(String text, {String locale = 'en'}) {
    final lower = text.toLowerCase().trim();

    if (_matches(lower, ['balance', 'رصيد', 'رصيدي', 'show my balance'])) {
      return VoiceCommand(
        intent: 'show_balance',
        rawText: text,
        locale: locale,
        route: '/home',
      );
    }
    if (_matches(lower, ['transfer', 'حوالة', 'تحويل', 'transfer money'])) {
      return VoiceCommand(
        intent: 'transfer',
        rawText: text,
        locale: locale,
        route: '/transfer',
      );
    }
    if (_matches(lower, [
      'transactions',
      'معاملات',
      'recent transactions',
      'آخر المعاملات',
    ])) {
      return VoiceCommand(
        intent: 'transactions',
        rawText: text,
        locale: locale,
        route: '/transaction-history',
      );
    }
    if (_matches(lower, [
      'electricity',
      'bill',
      'فاتورة',
      'pay electricity',
      'فاتورة الكهرباء',
    ])) {
      return VoiceCommand(
        intent: 'pay_bill',
        rawText: text,
        locale: locale,
        parameters: {'bill_type': 'electricity'},
        route: '/bill-payment',
      );
    }
    if (_matches(lower, ['cards', 'بطاقات', 'my cards', 'بطاقاتي'])) {
      return VoiceCommand(
        intent: 'cards',
        rawText: text,
        locale: locale,
        route: '/cards',
      );
    }
    if (_matches(lower, ['assistant', 'ai', 'مساعد', 'مساعد ذكي'])) {
      return VoiceCommand(
        intent: 'ai_assistant',
        rawText: text,
        locale: locale,
        route: '/ai-assistant',
      );
    }
    if (_matches(lower, ['budget', 'ميزانية'])) {
      return VoiceCommand(
        intent: 'budget',
        rawText: text,
        locale: locale,
        route: '/budget',
      );
    }

    return VoiceCommand(
      intent: 'unknown',
      rawText: text,
      locale: locale,
      route: '/ai-assistant',
    );
  }

  bool _matches(String text, List<String> keywords) {
    for (final k in keywords) {
      if (text.contains(k.toLowerCase())) return true;
    }
    return false;
  }
}
