/// In-app notification model.
class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    required this.icon,
    required this.color,
  });

  final String id;
  final String title;
  final String body;
  final DateTime time;
  final bool isRead;
  final String icon;
  final int color;
}
