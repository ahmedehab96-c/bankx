import 'package:equatable/equatable.dart';

import '../../../../../core/ai/models/ai_models.dart';

class AiAssistantState extends Equatable {
  const AiAssistantState({
    this.messages = const [],
    this.isLoading = false,
    this.isStreaming = false,
    this.streamingContent = '',
    this.errorMessage,
    this.suggestedRoute,
  });

  final List<AiMessage> messages;
  final bool isLoading;
  final bool isStreaming;
  final String streamingContent;
  final String? errorMessage;
  final String? suggestedRoute;

  AiAssistantState copyWith({
    List<AiMessage>? messages,
    bool? isLoading,
    bool? isStreaming,
    String? streamingContent,
    String? errorMessage,
    String? suggestedRoute,
    bool clearError = false,
  }) => AiAssistantState(
    messages: messages ?? this.messages,
    isLoading: isLoading ?? this.isLoading,
    isStreaming: isStreaming ?? this.isStreaming,
    streamingContent: streamingContent ?? this.streamingContent,
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    suggestedRoute: suggestedRoute ?? this.suggestedRoute,
  );

  @override
  List<Object?> get props => [
    messages,
    isLoading,
    isStreaming,
    streamingContent,
    errorMessage,
  ];
}
