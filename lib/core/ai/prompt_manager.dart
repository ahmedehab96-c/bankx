import 'models/ai_models.dart';

/// Manages system and feature-specific prompts for AI providers.
class PromptManager {
  const PromptManager();

  static const String systemPromptEn = '''
You are BankX AI, an intelligent financial assistant for a digital banking app.
Help users understand transactions, manage budgets, navigate the app, and make informed financial decisions.
Be concise, accurate, and security-conscious. Never request passwords or PINs.
If unsure, suggest contacting bank support.
''';

  static const String systemPromptAr = '''
أنت BankX AI، مساعد مالي ذكي لتطبيق بنكي رقمي.
ساعد المستخدمين في فهم المعاملات وإدارة الميزانيات والتنقل في التطبيق.
كن موجزاً ودقيقاً. لا تطلب كلمات المرور أو الرقم السري أبداً.
''';

  String systemPrompt({String locale = 'en'}) =>
      locale.startsWith('ar') ? systemPromptAr : systemPromptEn;

  String spendingAnalysisPrompt({
    required double totalSpent,
    required String topCategory,
  }) =>
      'Analyze spending: total $totalSpent AED, top category $topCategory. '
      'Provide 2-3 actionable savings tips.';

  String transactionExplainPrompt({
    required String title,
    required double amount,
    required String category,
  }) => 'Explain this transaction: $title, $amount AED, category $category.';

  String navigationPrompt(String userQuery) =>
      'User wants: "$userQuery". Suggest the best BankX app feature or screen.';

  List<AiMessage> buildChatMessages({
    required String userMessage,
    required List<AiMessage> history,
    String locale = 'en',
    Map<String, dynamic>? context,
  }) {
    final messages = <AiMessage>[
      AiMessage(
        id: 'system',
        role: AiMessageRole.system,
        content: systemPrompt(locale: locale),
        timestamp: DateTime.now(),
      ),
    ];

    if (context != null && context.isNotEmpty) {
      messages.add(
        AiMessage(
          id: 'context',
          role: AiMessageRole.system,
          content: 'User context: $context',
          timestamp: DateTime.now(),
        ),
      );
    }

    messages.addAll(history.take(20));
    messages.add(
      AiMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        role: AiMessageRole.user,
        content: userMessage,
        timestamp: DateTime.now(),
      ),
    );

    return messages;
  }
}
