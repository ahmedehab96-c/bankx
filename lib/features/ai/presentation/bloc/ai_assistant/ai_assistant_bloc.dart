import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/ai/models/ai_models.dart';
import '../../../../../core/utils/usecase.dart';
import '../../../domain/usecases/ai_usecases.dart';
import 'ai_assistant_event.dart';
import 'ai_assistant_state.dart';

class AiAssistantBloc extends Bloc<AiAssistantEvent, AiAssistantState> {
  AiAssistantBloc({
    required ChatStreamUseCase chatStreamUseCase,
    required ClearChatHistoryUseCase clearChatHistoryUseCase,
  }) : _chatStreamUseCase = chatStreamUseCase,
       _clearChatHistoryUseCase = clearChatHistoryUseCase,
       super(const AiAssistantState()) {
    on<AiMessageSent>(_onMessageSent);
    on<AiChatCleared>(_onCleared);
    on<AiSuggestionTapped>(_onSuggestion);
  }

  final ChatStreamUseCase _chatStreamUseCase;
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
        isStreaming: true,
        streamingContent: '',
        clearError: true,
      ),
    );

    try {
      final buffer = StringBuffer();
      await for (final chunk in _chatStreamUseCase(
        ChatStreamParams(
          message: event.message,
          locale: event.locale,
          userName: event.userName,
          balance: event.balance,
        ),
      )) {
        if (chunk.delta.isNotEmpty) {
          buffer.write(chunk.delta);
          emit(
            state.copyWith(
              streamingContent: buffer.toString(),
              isLoading: false,
            ),
          );
        }
        if (chunk.isDone) break;
      }

      final content = buffer.toString();
      if (content.isEmpty) {
        emit(
          state.copyWith(
            isLoading: false,
            isStreaming: false,
            errorMessage: 'No response from AI assistant.',
          ),
        );
        return;
      }

      final assistantMsg = AiMessage(
        id: _uuid.v4(),
        role: AiMessageRole.assistant,
        content: content,
        timestamp: DateTime.now(),
      );
      emit(
        state.copyWith(
          messages: [...state.messages, assistantMsg],
          isLoading: false,
          isStreaming: false,
          streamingContent: '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isStreaming: false,
          streamingContent: '',
          errorMessage: e.toString(),
        ),
      );
    }
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
