import 'package:equatable/equatable.dart';

abstract class AiAssistantEvent extends Equatable {
  const AiAssistantEvent();

  @override
  List<Object?> get props => [];
}

class AiMessageSent extends AiAssistantEvent {
  const AiMessageSent({
    required this.message,
    this.locale = 'en',
    this.userName,
    this.balance,
  });

  final String message;
  final String locale;
  final String? userName;
  final double? balance;

  @override
  List<Object?> get props => [message, locale];
}

class AiChatCleared extends AiAssistantEvent {
  const AiChatCleared();
}

class AiSuggestionTapped extends AiAssistantEvent {
  const AiSuggestionTapped(this.suggestion);
  final String suggestion;

  @override
  List<Object?> get props => [suggestion];
}
