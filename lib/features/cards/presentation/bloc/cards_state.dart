import 'package:equatable/equatable.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/card_model.dart';

class CardsState extends Equatable {
  const CardsState({
    this.listStatus = RequestStatus.initial,
    this.detailsStatus = RequestStatus.initial,
    this.freezeStatus = RequestStatus.initial,
    this.cards = const [],
    this.selectedCard,
    this.errorMessage,
  });

  final RequestStatus listStatus;
  final RequestStatus detailsStatus;
  final RequestStatus freezeStatus;
  final List<BankCard> cards;
  final BankCard? selectedCard;
  final String? errorMessage;

  CardsState copyWith({
    RequestStatus? listStatus,
    RequestStatus? detailsStatus,
    RequestStatus? freezeStatus,
    List<BankCard>? cards,
    BankCard? selectedCard,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CardsState(
      listStatus: listStatus ?? this.listStatus,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      freezeStatus: freezeStatus ?? this.freezeStatus,
      cards: cards ?? this.cards,
      selectedCard: selectedCard ?? this.selectedCard,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [listStatus, detailsStatus, freezeStatus, cards, selectedCard, errorMessage];
}
