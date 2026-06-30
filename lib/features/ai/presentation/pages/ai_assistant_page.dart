import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ai/models/ai_models.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/ai_assistant/ai_assistant_bloc.dart';
import '../bloc/ai_assistant/ai_assistant_event.dart';
import '../bloc/ai_assistant/ai_assistant_state.dart';

/// In-app AI financial assistant chat.
class AiAssistantPage extends StatefulWidget {
  const AiAssistantPage({super.key});

  @override
  State<AiAssistantPage> createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  static const _suggestions = [
    'Show my balance',
    'Analyze my spending',
    'Help with transfer',
    'Budget status',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send([String? text]) {
    final message = (text ?? _controller.text).trim();
    if (message.isEmpty) return;
    _controller.clear();
    context.read<AiAssistantBloc>().add(AiMessageSent(message: message));
    Future<void>.delayed(const Duration(milliseconds: 300), _scrollToBottom);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () =>
                context.read<AiAssistantBloc>().add(const AiChatCleared()),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<AiAssistantBloc, AiAssistantState>(
              listener: (context, state) {
                if (state.suggestedRoute != null) {
                  final route = state.suggestedRoute!;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Navigate to suggested feature?'),
                      action: SnackBarAction(
                        label: 'Open',
                        onPressed: () => context.pushRoute(route),
                      ),
                    ),
                  );
                }
                _scrollToBottom();
              },
              builder: (context, state) {
                if (state.messages.isEmpty) {
                  return _WelcomeSuggestions(onTap: _send);
                }
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: state.messages.length + (state.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.messages.length) {
                      return const _TypingIndicator();
                    }
                    return _MessageBubble(message: state.messages[index]);
                  },
                );
              },
            ),
          ),
          if (_suggestions.isNotEmpty)
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _suggestions.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (_, i) => ActionChip(
                  label: Text(_suggestions[i]),
                  onPressed: () => _send(_suggestions[i]),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.mic_outlined),
                  onPressed: () => context.pushVoiceBanking(),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask about your finances...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: () => _send(),
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeSuggestions extends StatelessWidget {
  const _WelcomeSuggestions({required this.onTap});
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.smart_toy_outlined,
              size: 64,
              color: AppColors.primaryBlue.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 16),
            Text(
              'BankX AI Assistant',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Ask me about balances, spending, transfers, and more.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});
  final AiMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == AiMessageRole.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? AppColors.primaryBlue
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.content,
          style: TextStyle(color: isUser ? Colors.white : null),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
