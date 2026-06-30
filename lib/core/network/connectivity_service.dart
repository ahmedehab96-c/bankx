import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Wraps [Connectivity] to observe network type changes.
class ConnectivityService {
  ConnectivityService({
    Connectivity? connectivity,
    InternetConnection? internetChecker,
  }) : _connectivity = connectivity ?? Connectivity(),
       _internetChecker = internetChecker ?? InternetConnection();

  final Connectivity _connectivity;
  final InternetConnection _internetChecker;

  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  Future<bool> hasNetworkInterface() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  Future<bool> hasInternetAccess() => _internetChecker.hasInternetAccess;
}
