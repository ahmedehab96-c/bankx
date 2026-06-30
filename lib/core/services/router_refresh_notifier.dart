import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bridges BLoC streams to GoRouter [refreshListenable].
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(List<BlocBase<dynamic>> blocs) {
    for (final bloc in blocs) {
      _subscriptions.add(bloc.stream.listen((_) => notifyListeners()));
    }
  }

  final List<StreamSubscription<dynamic>> _subscriptions = [];

  @override
  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    super.dispose();
  }
}
