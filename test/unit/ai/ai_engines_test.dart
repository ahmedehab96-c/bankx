import 'package:bankx/core/ai/engines/smart_search_engine.dart';
import 'package:bankx/core/ai/engines/spending_analyzer.dart';
import 'package:bankx/core/ai/engines/voice_command_parser.dart';
import 'package:bankx/shared/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SpendingAnalyzer', () {
    test('categorizes expenses and computes totals', () {
      const analyzer = SpendingAnalyzer();
      final txs = [
        Transaction(
          id: '1',
          title: 'Restaurant',
          subtitle: 'Dinner',
          amount: 200,
          currency: 'AED',
          type: TransactionType.expense,
          status: TransactionStatus.completed,
          date: DateTime(2026, 6, 1),
          category: 'food',
          icon: 'restaurant',
          reference: 'R1',
          accountId: 'a1',
        ),
        Transaction(
          id: '2',
          title: 'Salary',
          subtitle: 'Employer',
          amount: 5000,
          currency: 'AED',
          type: TransactionType.income,
          status: TransactionStatus.completed,
          date: DateTime(2026, 6, 1),
          category: 'income',
          icon: 'payments',
          reference: 'R2',
          accountId: 'a1',
        ),
      ];

      final result = analyzer.analyze(txs);
      expect(result.totalSpent, 200);
      expect(result.categories, isNotEmpty);
      expect(result.summary, contains('200'));
    });
  });

  group('SmartSearchEngine', () {
    test('filters transactions above amount', () {
      const engine = SmartSearchEngine();
      final txs = [_expense('1', 100), _expense('2', 600)];
      final result = engine.search('payments above 500', txs);
      expect(result.transactionIds, ['2']);
      expect(result.interpretation, contains('500'));
    });
  });

  group('VoiceCommandParser', () {
    test('parses English balance command', () {
      const parser = VoiceCommandParser();
      final cmd = parser.parse('Show my balance');
      expect(cmd.intent, 'show_balance');
      expect(cmd.route, '/home');
    });

    test('parses Arabic transfer command', () {
      const parser = VoiceCommandParser();
      final cmd = parser.parse('تحويل', locale: 'ar');
      expect(cmd.intent, 'transfer');
    });
  });
}

Transaction _expense(String id, double amount) => Transaction(
  id: id,
  title: 'Test',
  subtitle: 'Test',
  amount: amount,
  currency: 'AED',
  type: TransactionType.expense,
  status: TransactionStatus.completed,
  date: DateTime.now(),
  category: 'other',
  icon: 'icon',
  reference: 'ref',
  accountId: 'a1',
);
