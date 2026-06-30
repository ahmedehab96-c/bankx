import '../../../../core/network/network_bound_resource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/notification_model.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_local_data_source.dart';
import '../datasources/notifications_remote_data_source.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl({
    required NotificationsLocalDataSource local,
    required NotificationsRemoteDataSource remote,
    required NetworkInfo networkInfo,
  }) : _local = local,
       _remote = remote,
       _networkInfo = networkInfo,
       _remoteResource = RemoteResource(networkInfo: networkInfo);

  final NotificationsLocalDataSource _local;
  final NotificationsRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final RemoteResource _remoteResource;

  @override
  ResultFuture<List<AppNotification>> getNotifications() =>
      NetworkBoundResource(
        networkInfo: _networkInfo,
        fetchRemote: _remote.fetchNotifications,
        fetchLocal: _local.getCachedNotifications,
        saveLocal: (_) async {},
      ).execute();

  @override
  ResultFuture<List<AppNotification>> markNotificationRead(int index) =>
      _remoteResource.execute(() => _remote.markNotificationRead(index));
}
