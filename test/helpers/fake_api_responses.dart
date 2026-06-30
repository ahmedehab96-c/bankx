import 'package:bankx/shared/data/dto/banking_dtos.dart';

import 'test_fixtures.dart';

/// Static fake API payloads mirroring backend responses for repository tests.
abstract final class FakeApiResponses {
  static AuthResponseDto get login => TestFixtures.authResponse;

  static AuthTokensDto get tokens => const AuthTokensDto(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
      );

  static SettingsDto get settings => const SettingsDto(
        themeMode: 'light',
        locale: 'en',
      );

  static Map<String, dynamic> get dashboardJson => {
        'user': {
          'id': TestFixtures.user.id,
          'name': TestFixtures.user.name,
          'email': TestFixtures.user.email,
        },
        'total_balance': TestFixtures.dashboardData.totalBalance,
        'accounts': <Map<String, dynamic>>[],
        'recent_transactions': <Map<String, dynamic>>[],
        'weekly_spending': TestFixtures.dashboardData.weeklySpending,
        'weekly_labels': TestFixtures.dashboardData.weeklyLabels,
      };
}
