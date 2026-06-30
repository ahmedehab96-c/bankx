import 'package:bankx/core/ai/models/ai_models.dart';
import 'package:bankx/core/di/injection.dart';
import 'package:bankx/core/security/screenshot_protection_service.dart';
import 'package:bankx/core/utils/result.dart';
import 'package:bankx/features/ai/domain/usecases/ai_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:google_fonts/google_fonts.dart';

/// Minimal GetIt registrations required by widget tests (e.g. QR payment screen).
Future<void> registerWidgetTestDependencies() async {
  GoogleFonts.config.allowRuntimeFetching = false;

  if (!getIt.isRegistered<ScreenshotProtectionService>()) {
    getIt.registerLazySingleton<ScreenshotProtectionService>(
      _FakeScreenshotProtectionService.new,
    );
  }

  if (!getIt.isRegistered<GetPersonalizedInsightsUseCase>()) {
    getIt.registerLazySingleton<GetPersonalizedInsightsUseCase>(
      _FakeGetPersonalizedInsightsUseCase.new,
    );
  }
}

Future<void> tearDownWidgetTestDependencies() async {
  if (getIt.isRegistered<ScreenshotProtectionService>() ||
      getIt.isRegistered<GetPersonalizedInsightsUseCase>()) {
    await getIt.reset(dispose: false);
  }
}

class _FakeScreenshotProtectionService extends ScreenshotProtectionService {
  @override
  Future<void> enable() async {}

  @override
  Future<void> disable() async {}
}

class _FakeGetPersonalizedInsightsUseCase
    implements GetPersonalizedInsightsUseCase {
  @override
  ResultFuture<PersonalizedInsights> call(double params) async =>
      const Right(
        PersonalizedInsights(
          monthlySummary: 'Test insights',
          financeScore: 80,
          savingSuggestions: [],
          upcomingBills: [],
          spendingHighlights: [],
        ),
      );
}
