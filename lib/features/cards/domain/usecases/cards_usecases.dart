import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../shared/domain/entities/card_model.dart';
import '../repositories/cards_repository.dart';

class GetCardsUseCase implements UseCase<List<BankCard>, NoParams> {
  GetCardsUseCase(this._repository);

  final CardsRepository _repository;

  @override
  ResultFuture<List<BankCard>> call(NoParams params) => _repository.getCards();
}

class GetCardByIdParams {
  const GetCardByIdParams(this.id);

  final String id;
}

class GetCardByIdUseCase implements UseCase<BankCard, GetCardByIdParams> {
  GetCardByIdUseCase(this._repository);

  final CardsRepository _repository;

  @override
  ResultFuture<BankCard> call(GetCardByIdParams params) =>
      _repository.getCardById(params.id);
}

class ToggleCardFreezeParams {
  const ToggleCardFreezeParams(this.cardId);

  final String cardId;
}

class ToggleCardFreezeUseCase
    implements UseCase<BankCard, ToggleCardFreezeParams> {
  ToggleCardFreezeUseCase(this._repository);

  final CardsRepository _repository;

  @override
  ResultFuture<BankCard> call(ToggleCardFreezeParams params) =>
      _repository.toggleCardFreeze(params.cardId);
}
