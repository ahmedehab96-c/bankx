import 'package:bankx/core/ai/models/ai_models.dart';
import 'package:bankx/core/utils/usecase.dart';
import 'package:bankx/features/ai/domain/usecases/ai_usecases.dart';
import 'package:bankx/features/ai/presentation/bloc/ai_assistant/ai_assistant_bloc.dart';
import 'package:bankx/features/ai/presentation/bloc/ai_assistant/ai_assistant_event.dart';
import 'package:bankx/features/ai/presentation/bloc/ai_assistant/ai_assistant_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/result_helpers.dart';

class MockChatStreamUseCase extends Mock implements ChatStreamUseCase {}

class MockClearChatHistoryUseCase extends Mock
    implements ClearChatHistoryUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(const ChatStreamParams(message: ''));
    registerFallbackValue(const NoParams());
  });

  late MockChatStreamUseCase chatStreamUseCase;
  late MockClearChatHistoryUseCase clearChatHistoryUseCase;

  AiAssistantBloc buildBloc() => AiAssistantBloc(
    chatStreamUseCase: chatStreamUseCase,
    clearChatHistoryUseCase: clearChatHistoryUseCase,
  );

  setUp(() {
    chatStreamUseCase = MockChatStreamUseCase();
    clearChatHistoryUseCase = MockClearChatHistoryUseCase();
  });

  test('initial state is empty', () {
    expect(buildBloc().state, const AiAssistantState());
  });

  blocTest<AiAssistantBloc, AiAssistantState>(
    'streams assistant reply on message sent',
    build: () {
      when(() => chatStreamUseCase(any())).thenAnswer(
        (_) => Stream.fromIterable([
          const AiStreamChunk(delta: 'Hello'),
          const AiStreamChunk(delta: ' Ahmed', isDone: true),
        ]),
      );
      return buildBloc();
    },
    act: (bloc) => bloc.add(const AiMessageSent(message: 'Hi')),
    expect: () => [
      isA<AiAssistantState>()
          .having((s) => s.messages.length, 'messages', 1)
          .having((s) => s.isStreaming, 'streaming', true),
      isA<AiAssistantState>().having(
        (s) => s.streamingContent,
        'stream',
        'Hello',
      ),
      isA<AiAssistantState>().having(
        (s) => s.streamingContent,
        'stream',
        'Hello Ahmed',
      ),
      isA<AiAssistantState>()
          .having((s) => s.messages.length, 'messages', 2)
          .having((s) => s.isStreaming, 'streaming', false),
    ],
  );

  blocTest<AiAssistantBloc, AiAssistantState>(
    'clears chat on AiChatCleared',
    build: () {
      when(
        () => clearChatHistoryUseCase(any()),
      ).thenAnswer((_) async => futureRightVoid());
      return buildBloc();
    },
    seed: () => AiAssistantState(
      messages: [
        AiMessage(
          id: '1',
          role: AiMessageRole.user,
          content: 'Hi',
          timestamp: DateTime(2026, 6, 1),
        ),
      ],
    ),
    act: (bloc) => bloc.add(const AiChatCleared()),
    expect: () => [const AiAssistantState()],
  );
}
