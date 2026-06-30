import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/performance/bloc_build_when.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../bloc/notifications_bloc.dart';
import '../bloc/notifications_event.dart';
import '../bloc/notifications_state.dart';

/// Notifications list with read/unread states.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocBuilder<NotificationsBloc, NotificationsState>(
      buildWhen: BlocBuildWhen.notificationsList,
      builder: (context, state) {
        if (state.status == RequestStatus.loading) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.notifications)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.notifications),
            actions: [
              TextButton(
                onPressed: () => context
                    .read<NotificationsBloc>()
                    .add(const AllNotificationsMarkedRead()),
                child: Text(l10n.markAllRead),
              ),
            ],
          ),
          body: ListView.separated(
            padding: EdgeInsets.all(padding),
            itemCount: state.notifications.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final n = state.notifications[i];
              final isRead = n.isRead;

              return Dismissible(
                key: ValueKey(n.id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {},
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete_outline, color: Colors.red),
                ),
                child: Material(
                  color: isRead
                      ? Theme.of(context).cardTheme.color
                      : Color(n.color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () => context
                        .read<NotificationsBloc>()
                        .add(NotificationMarkedRead(i)),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Color(n.color).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _iconFor(n.icon),
                              color: Color(n.color),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  n.title,
                                  style: GoogleFonts.inter(
                                    fontWeight: isRead
                                        ? FontWeight.w500
                                        : FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  n.body,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  AppFormatters.timeAgo(n.time),
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Color(n.color),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  IconData _iconFor(String icon) {
    return switch (icon) {
      'transfer' => Icons.swap_horiz_rounded,
      'card' => Icons.credit_card_rounded,
      'security' => Icons.shield_outlined,
      'cashback' => Icons.card_giftcard_rounded,
      _ => Icons.notifications_outlined,
    };
  }
}
