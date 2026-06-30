import 'package:flutter/material.dart';

/// Hides sensitive UI when the app is backgrounded (app-switcher privacy).
class AppLifecycleGuard extends StatefulWidget {
  const AppLifecycleGuard({super.key, required this.child});

  final Widget child;

  @override
  State<AppLifecycleGuard> createState() => _AppLifecycleGuardState();
}

class _AppLifecycleGuardState extends State<AppLifecycleGuard>
    with WidgetsBindingObserver {
  bool _obscured = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _obscured =
          state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused ||
          state == AppLifecycleState.hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      textDirection: TextDirection.ltr,
      children: [
        widget.child,
        if (_obscured)
          const Positioned.fill(
            child: ColoredBox(
              color: Color(0xFF0A1628),
              child: Center(
                child: Icon(
                  Icons.lock_rounded,
                  color: Colors.white54,
                  size: 48,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
