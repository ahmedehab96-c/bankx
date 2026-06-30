import 'package:equatable/equatable.dart';

abstract class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object?> get props => [];
}

class CardsLoaded extends CardsEvent {
  const CardsLoaded();
}

class CardDetailsLoaded extends CardsEvent {
  const CardDetailsLoaded(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class CardFreezeToggled extends CardsEvent {
  const CardFreezeToggled(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
