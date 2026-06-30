import 'package:bankx/core/ai/security/ai_dio_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CertificatePinner', () {
    test('parsePins splits comma-separated values', () {
      final pins = CertificatePinner.parsePins(' abc , DEF , ');
      expect(pins, ['abc', 'def']);
    });

    test('parsePins filters empty segments', () {
      expect(CertificatePinner.parsePins(''), isEmpty);
      expect(CertificatePinner.parsePins(' , , '), isEmpty);
    });
  });

  group('AiDioFactory', () {
    test('create returns configured Dio instance', () {
      final dio = AiDioFactory.create(
        baseUrl: 'https://example.com/v1',
        headers: {'Content-Type': 'application/json'},
      );
      expect(dio.options.baseUrl, 'https://example.com/v1');
      expect(dio.options.headers?['Content-Type'], 'application/json');
    });
  });
}
