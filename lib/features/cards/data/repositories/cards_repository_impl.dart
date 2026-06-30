import '../../../../core/network/network_bound_resource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/card_model.dart';
import '../../domain/repositories/cards_repository.dart';
import '../datasources/cards_local_data_source.dart';
import '../datasources/cards_remote_data_source.dart';

class CardsRepositoryImpl implements CardsRepository {
  CardsRepositoryImpl({
    required CardsLocalDataSource local,
    required CardsRemoteDataSource remote,
    required NetworkInfo networkInfo,
  })  : _local = local,
        _remote = remote,
        _networkInfo = networkInfo,
        _remoteResource = RemoteResource(networkInfo: networkInfo);

  final CardsLocalDataSource _local;
  final CardsRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final RemoteResource _remoteResource;

  @override
  ResultFuture<List<BankCard>> getCards() => NetworkBoundResource(
        networkInfo: _networkInfo,
        fetchRemote: _remote.fetchCards,
        fetchLocal: _local.getCachedCards,
        saveLocal: (_) async {},
      ).execute();

  @override
  ResultFuture<BankCard> getCardById(String id) => NetworkBoundResource(
        networkInfo: _networkInfo,
        fetchRemote: () => _remote.fetchCardById(id),
        fetchLocal: () => _local.getCachedCardById(id),
        saveLocal: (_) async {},
      ).execute();

  @override
  ResultFuture<BankCard> toggleCardFreeze(String cardId) =>
      _remoteResource.execute(() => _remote.toggleCardFreeze(cardId));
}
