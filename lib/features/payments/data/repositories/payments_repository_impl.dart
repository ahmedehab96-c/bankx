import '../../../../core/network/network_bound_resource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/payments_repository.dart';
import '../../domain/usecases/payments_usecases.dart';
import '../datasources/payments_local_data_source.dart';
import '../datasources/payments_remote_data_source.dart';

class PaymentsRepositoryImpl implements PaymentsRepository {
  PaymentsRepositoryImpl({
    required PaymentsLocalDataSource local,
    required PaymentsRemoteDataSource remote,
    required NetworkInfo networkInfo,
  })  : _local = local,
        _remote = remote,
        _networkInfo = networkInfo,
        _remoteResource = RemoteResource(networkInfo: networkInfo);

  final PaymentsLocalDataSource _local;
  final PaymentsRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final RemoteResource _remoteResource;

  @override
  ResultFuture<QrPaymentData> getQrPaymentData() => NetworkBoundResource(
        networkInfo: _networkInfo,
        fetchRemote: _remote.fetchQrPaymentData,
        fetchLocal: _local.getCachedQrPaymentData,
        saveLocal: (_) async {},
      ).execute();

  @override
  ResultFuture<void> submitBillPayment({
    required double amount,
    required String billType,
  }) =>
      _remoteResource.executeVoid(
        () => _remote.submitBillPayment(amount: amount, billType: billType),
      );
}
