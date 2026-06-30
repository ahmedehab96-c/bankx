/// Current user profile model.
class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.memberSince,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final DateTime memberSince;
}
