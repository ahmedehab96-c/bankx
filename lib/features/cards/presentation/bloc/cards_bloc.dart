import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/cards_usecases.dart';
import 'cards_event.dart';
import 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc({
    required GetCardsUseCase getCardsUseCase,
    required GetCardByIdUseCase getCardByIdUseCase,
    required ToggleCardFreezeUseCase toggleCardFreezeUseCase,
  })  : _getCardsUseCase = getCardsUseCase,
        _getCardByIdUseCase = getCardByIdUseCase,
        _toggleCardFreezeUseCase = toggleCardFreezeUseCase,
        super(const CardsState()) {
    on<CardsLoaded>(_onCardsLoaded);
    on<CardDetailsLoaded>(_onCardDetailsLoaded);
    on<CardFreezeToggled>(_onCardFreezeToggled);
  }

  final GetCardsUseCase _getCardsUseCase;
  final GetCardByIdUseCase _getCardByIdUseCase;
  final ToggleCardFreezeUseCase _toggleCardFreezeUseCase;

  Future<void> _onCardsLoaded(
    CardsLoaded event,
    Emitter<CardsState> emit,
  ) async {
    emit(state.copyWith(listStatus: RequestStatus.loading, clearError: true));
    final result = await _getCardsUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          listStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (cards) => emit(
        state.copyWith(
          listStatus: RequestStatus.success,
          cards: cards,
        ),
      ),
    );
  }

  Future<void> _onCardDetailsLoaded(
    CardDetailsLoaded event,
    Emitter<CardsState> emit,
  ) async {
    emit(state.copyWith(detailsStatus: RequestStatus.loading, clearError: true));
    final result = await _getCardByIdUseCase(GetCardByIdParams(event.id));
    result.fold(
      (failure) => emit(
        state.copyWith(
          detailsStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (card) => emit(
        state.copyWith(
          detailsStatus: RequestStatus.success,
          selectedCard: card,
        ),
      ),
    );
  }

  Future<void> _onCardFreezeToggled(
    CardFreezeToggled event,
    Emitter<CardsState> emit,
  ) async {
    emit(state.copyWith(freezeStatus: RequestStatus.loading, clearError: true));
    final result = await _toggleCardFreezeUseCase(ToggleCardFreezeParams(event.id));
    result.fold(
      (failure) => emit(
        state.copyWith(
          freezeStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (updatedCard) {
        final updatedCards = state.cards
            .map((c) => c.id == updatedCard.id ? updatedCard : c)
            .toList();
        emit(
          state.copyWith(
            freezeStatus: RequestStatus.success,
            cards: updatedCards,
            selectedCard: state.selectedCard?.id == updatedCard.id
                ? updatedCard
                : state.selectedCard,
          ),
        );
      },
    );
  }
}
