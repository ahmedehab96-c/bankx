import 'package:bankx/core/ai/models/ai_models.dart';
import 'package:bankx/core/ai/providers/openai_response_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OpenAiResponseParser', () {
    test('parseCompletion extracts content and tokens', () {
      final response = OpenAiResponseParser.parseCompletion({
        'choices': [
          {
            'message': {'content': 'Hello from BankX'},
          },
        ],
        'usage': {'total_tokens': 42},
      });

      expect(response.content, 'Hello from BankX');
      expect(response.tokensUsed, 42);
    });

    test('parseStreamLine extracts delta content', () {
      const line =
          'data: {"choices":[{"delta":{"content":"Hi"}}]}';
      expect(OpenAiResponseParser.parseStreamLine(line), 'Hi');
      expect(OpenAiResponseParser.parseStreamLine('data: [DONE]'), isNull);
    });
  });
}
