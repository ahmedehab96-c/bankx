import 'package:flutter/material.dart';

import '../../../../core/ai/ai_config.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/widgets/ai_insights_card.dart';
import '../../domain/usecases/ai_usecases.dart';

/// Loads AI insights for the home dashboard without modifying existing layout.
class HomeAiInsightsSection extends StatefulWidget {
  const HomeAiInsightsSection({super.key, required this.balance});

  final double balance;

  @override
  State<HomeAiInsightsSection> createState() => _HomeAiInsightsSectionState();
}

class _HomeAiInsightsSectionState extends State<HomeAiInsightsSection> {
  String? _summary;
  int _score = 0;
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    if (AiConfig.enabled) _load();
  }

  Future<void> _load() async {
    final useCase = getIt<GetPersonalizedInsightsUseCase>();
    final result = await useCase(widget.balance);
    result.fold((_) {}, (insights) {
      if (mounted) {
        setState(() {
          _summary = insights.monthlySummary;
          _score = insights.financeScore;
          _suggestions = insights.savingSuggestions;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!AiConfig.enabled || _summary == null) {
      return const SizedBox.shrink();
    }

    return AiInsightsCard(
      summary: _summary!,
      financeScore: _score,
      suggestions: _suggestions,
      onTap: () => context.pushAiAssistant(),
    );
  }
}
