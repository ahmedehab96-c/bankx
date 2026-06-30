import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/ai/models/ai_models.dart';
import '../../../../../core/utils/usecase.dart';
import '../../../domain/usecases/ai_usecases.dart';
import 'ai_assistant_event.dart';
import 'ai_assistant_state.dart';

class AiAssistantBloc extends Bloc<AiAssistantEvent, AiAssistantState> {
  AiAssistantBloc({
    required ChatUseCase chatUseCase,
    required ClearChatHistoryUseCase clearChatHistoryUseCase,
  }) : _chatUseCase = chatUseCase,
       _clearChatHistoryUseCase = clearChatHistoryUseCase,
       super(const AiAssistantState()) {
    on<AiMessageSent>(_onMessageSent);
    on<AiChatCleared>(_onCleared);
    on<AiSuggestionTapped>(_onSuggestion);
  }

  final ChatUseCase _chatUseCase;
  final ClearChatHistoryUseCase _clearChatHistoryUseCase;
  final _uuid = const Uuid();

  Future<void> _onMessageSent(
    AiMessageSent event,
    Emitter<AiAssistantState> emit,
  ) async {
    final userMsg = AiMessage(
      id: _uuid.v4(),
      role: AiMessageRole.user,
      content: event.message,
      timestamp: DateTime.now(),
    );

    emit(
      state.copyWith(
        messages: [...state.messages, userMsg],
        isLoading: true,
        clearError: true,
      ),
    );

    final result = await _chatUseCase(
      ChatParams(
        message: event.message,
        locale: event.locale,
        userName: event.userName,
        balance: event.balance,
      ),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (response) {
        final assistantMsg = AiMessage(
          id: _uuid.v4(),
          role: AiMessageRole.assistant,
          content: response.content,
          timestamp: DateTime.now(),
        );
        emit(
          state.copyWith(
            messages: [...state.messages, assistantMsg],
            isLoading: false,
            suggestedRoute: response.suggestedRoute,
          ),
        );
      },
    );
  }

  Future<void> _onCleared(
    AiChatCleared event,
    Emitter<AiAssistantState> emit,
  ) async {
    await _clearChatHistoryUseCase(const NoParams());
    emit(const AiAssistantState());
  }

  Future<void> _onSuggestion(
    AiSuggestionTapped event,
    Emitter<AiAssistantState> emit,
  ) async {
    add(AiMessageSent(message: event.suggestion));
  }
}
