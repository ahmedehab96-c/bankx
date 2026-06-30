import 'package:bankx/core/ai/engines/budget_engine.dart';
import 'package:bankx/core/ai/engines/expense_predictor.dart';
import 'package:bankx/core/ai/engines/fraud_detector.dart';
import 'package:bankx/core/ai/engines/receipt_parser.dart';
import 'package:bankx/core/ai/models/ai_models.dart';
import 'package:bankx/core/ai/providers/mock_ai_provider.dart';
import 'package:bankx/shared/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockAiProvider', () {
    test('responds to balance query', () async {
      final provider = MockAiProvider()..updateContext(balance: 3200);
      final response = await provider.complete(
        messages: [
          AiMessage(
            id: '1',
            role: AiMessageRole.user,
            content: 'What is my balance?',
            timestamp: DateTime.now(),
          ),
        ],
      );
      expect(response.content, contains('3200'));
    });

    test('streams word by word', () async {
      final provider = MockAiProvider();
      final chunks = await provider
          .stream(
            messages: [
              AiMessage(
                id: '1',
                role: AiMessageRole.user,
                content: 'help',
                timestamp: DateTime.now(),
              ),
            ],
          )
          .toList();
      expect(chunks.any((c) => c.delta.isNotEmpty), isTrue);
      expect(chunks.last.isDone, isTrue);
    });
  });

  group('BudgetEngine', () {
    test('flags overspending categories', () {
      const engine = BudgetEngine();
      final txs = [
        _expense('1', 2500, category: 'food'),
        _expense('2', 100, category: 'transport'),
      ];
      final budgets = engine.buildDefaultBudgets(txs);
      final warnings = engine.predictOverspending(budgets);
      expect(budgets, isNotEmpty);
      expect(warnings, isNotEmpty);
    });
  });

  group('ExpensePredictor', () {
    test('forecasts end of month balance', () {
      const predictor = ExpensePredictor();
      final result = predictor.predict(
        transactions: [_expense('1', 500), _expense('2', 300)],
        currentBalance: 5000,
      );
      expect(result.endOfMonthBalance, lessThan(5000));
      expect(result.expectedExpenses, greaterThan(0));
    });
  });

  group('FraudDetector', () {
    test('detects repeated failed logins', () {
      const detector = FraudDetector();
      final signals = detector.analyze(failedLoginCount: 5);
      expect(signals, isNotEmpty);
      expect(signals.first.type, FraudSignalType.repeatedFailedLogin);
    });
  });

  group('ReceiptParser', () {
    test('parses merchant and total from OCR text', () {
      const parser = ReceiptParser();
      final receipt = parser.parse(
        'Carrefour\nTotal AED 125.50\nDate 2026-06-01',
      );
      expect(receipt.merchantName, 'Carrefour');
      expect(receipt.amount, closeTo(125.5, 0.01));
    });
  });
}

Transaction _expense(String id, double amount, {String category = 'other'}) =>
    Transaction(
      id: id,
      title: 'Test',
      subtitle: 'Test',
      amount: amount,
      currency: 'AED',
      type: TransactionType.expense,
      status: TransactionStatus.completed,
      date: DateTime.now(),
      category: category,
      icon: 'icon',
      reference: 'ref',
      accountId: 'a1',
    );
