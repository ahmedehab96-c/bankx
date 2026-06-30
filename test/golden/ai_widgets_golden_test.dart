import 'package:bankx/core/ai/models/ai_models.dart';
import 'package:bankx/core/widgets/ai_insights_card.dart';
import 'package:bankx/features/ai/presentation/widgets/smart_alert_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

@Tags(['golden'])
void main() {
  group('AI widget goldens', () {
    testWidgets('AiInsightsCard', (tester) async {
      await pumpLocalizedWidget(
        tester,
        const Padding(
          padding: EdgeInsets.all(16),
          child: AiInsightsCard(
            summary:
                'You spent 2,400 AED this month. Food is your top category.',
            financeScore: 82,
            suggestions: ['Cut dining by 15% to save 360 AED'],
          ),
        ),
      );

      await expectLater(
        find.byType(AiInsightsCard),
        matchesGoldenFile('goldens/ai_insights_card.png'),
      );
    });

    testWidgets('SmartAlertTile warning', (tester) async {
      await pumpLocalizedWidget(
        tester,
        Padding(
          padding: const EdgeInsets.all(16),
          child: SmartAlertTile(
            alert: SmartAlert(
              id: 'budget_food',
              type: SmartAlertType.budgetExceeded,
              title: 'Budget Exceeded',
              body: 'Food budget exceeded by 250 AED',
              severity: AlertSeverity.warning,
              createdAt: DateTime(2026, 6, 1, 12),
              actionRoute: '/budget',
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmartAlertTile),
        matchesGoldenFile('goldens/smart_alert_tile_warning.png'),
      );
    });
  });
}
