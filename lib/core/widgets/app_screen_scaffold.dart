import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/responsive.dart';

/// Reusable scaffold with consistent padding, app bar, and back button.
class AppScreenScaffold extends StatelessWidget {
  const AppScreenScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.showBackButton = true,
    this.centerTitle = true,
  }) : _scroll = false;

  const AppScreenScaffold.scroll({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.showBackButton = true,
    this.centerTitle = true,
  }) : _scroll = true;

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showBackButton;
  final bool centerTitle;
  final bool _scroll;

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: centerTitle,
        title: Text(title),
        leading: showBackButton && context.canPop()
            ? BackButton(onPressed: () => context.pop())
            : null,
        actions: actions,
      ),
      floatingActionButton: floatingActionButton,
      body: _scroll
          ? SingleChildScrollView(padding: EdgeInsets.all(padding), child: body)
          : Padding(padding: EdgeInsets.all(padding), child: body),
    );
  }
}

/// Auth flow header with title and subtitle.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            color: Theme.of(context).hintColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

/// Not-found placeholder for detail screens.
class NotFoundBody extends StatelessWidget {
  const NotFoundBody({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: '',
      showBackButton: true,
      body: Center(child: Text(message)),
    );
  }
}

/// Simulates async action with loading state and optional navigation.
Future<void> runMockAction(
  BuildContext context, {
  required VoidCallback setLoading,
  required VoidCallback clearLoading,
  Duration delay = const Duration(milliseconds: 1000),
  String? successMessage,
  VoidCallback? onSuccess,
}) async {
  setLoading();
  await Future<void>.delayed(delay);
  clearLoading();
  if (!context.mounted) return;
  if (successMessage != null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(successMessage)));
  }
  onSuccess?.call();
}
