import 'package:flutter/material.dart';

import '../di/injection.dart';
import 'session_manager.dart';

/// Propagates pointer/tap events to [SessionManager] for inactivity tracking.
class SessionActivityDetector extends StatelessWidget {
  const SessionActivityDetector({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => getIt<SessionManager>().recordActivity(),
      child: child,
    );
  }
}
