import 'dart:convert';

/// Builds and parses BankX payment QR payloads.
abstract final class QrPaymentCodec {
  static String encodeReceive({
    required String accountNumber,
    required String iban,
    required String name,
    double? amount,
  }) {
    final payload = {
      'type': 'bankx_receive',
      'accountNumber': accountNumber,
      'iban': iban,
      'name': name,
      'amount': ?amount,
    };
    return jsonEncode(payload);
  }

  static Map<String, dynamic>? decode(String raw) {
    try {
      final data = jsonDecode(raw);
      if (data is Map<String, dynamic> && data['type'] == 'bankx_receive') {
        return data;
      }
    } catch (_) {}
    return null;
  }
}
