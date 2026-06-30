import 'package:get_it/get_it.dart';

import '../../features/accounts/data/datasources/accounts_local_data_source.dart';
import '../../features/accounts/data/datasources/accounts_local_data_source_impl.dart';
import '../../features/accounts/data/datasources/accounts_remote_data_source.dart';
import '../../features/accounts/data/datasources/accounts_remote_data_source_impl.dart';
import '../../features/accounts/data/repositories/accounts_repository_impl.dart';
import '../../features/accounts/domain/repositories/accounts_repository.dart';
import '../../features/accounts/domain/usecases/accounts_usecases.dart';
import '../../features/accounts/presentation/bloc/accounts_bloc.dart';
import '../../features/ai/data/repositories/ai_repository_impl.dart';
import '../../features/ai/domain/repositories/ai_repository.dart';
import '../../features/ai/domain/usecases/ai_usecases.dart';
import '../../features/ai/presentation/bloc/ai_assistant/ai_assistant_bloc.dart';
import '../../features/ai/presentation/bloc/ai_finance/ai_finance_bloc.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_local_data_source_impl.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecases.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/cards/data/datasources/cards_local_data_source.dart';
import '../../features/cards/data/datasources/cards_local_data_source_impl.dart';
import '../../features/cards/data/datasources/cards_remote_data_source.dart';
import '../../features/cards/data/datasources/cards_remote_data_source_impl.dart';
import '../../features/cards/data/repositories/cards_repository_impl.dart';
import '../../features/cards/domain/repositories/cards_repository.dart';
import '../../features/cards/domain/usecases/cards_usecases.dart';
import '../../features/cards/presentation/bloc/cards_bloc.dart';
import '../../features/dashboard/data/datasources/dashboard_local_data_source.dart';
import '../../features/dashboard/data/datasources/dashboard_local_data_source_impl.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_data_source_impl.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/dashboard_usecases.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/notifications/data/datasources/notifications_local_data_source.dart';
import '../../features/notifications/data/datasources/notifications_local_data_source_impl.dart';
import '../../features/notifications/data/datasources/notifications_remote_data_source.dart';
import '../../features/notifications/data/datasources/notifications_remote_data_source_impl.dart';
import '../../features/notifications/data/repositories/notifications_repository_impl.dart';
import '../../features/notifications/domain/repositories/notifications_repository.dart';
import '../../features/notifications/domain/usecases/notifications_usecases.dart';
import '../../features/notifications/presentation/bloc/notifications_bloc.dart';
import '../../features/payments/data/datasources/payments_local_data_source.dart';
import '../../features/payments/data/datasources/payments_local_data_source_impl.dart';
import '../../features/payments/data/datasources/payments_remote_data_source.dart';
import '../../features/payments/data/datasources/payments_remote_data_source_impl.dart';
import '../../features/payments/data/repositories/payments_repository_impl.dart';
import '../../features/payments/domain/repositories/payments_repository.dart';
import '../../features/payments/domain/usecases/payments_usecases.dart';
import '../../features/payments/presentation/bloc/payments_bloc.dart';
import '../../features/profile/data/datasources/profile_local_data_source.dart';
import '../../features/profile/data/datasources/profile_local_data_source_impl.dart';
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/datasources/profile_remote_data_source_impl.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/profile_usecases.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/security/data/repositories/security_repository_impl.dart';
import '../../features/security/domain/repositories/security_repository.dart';
import '../../features/security/domain/usecases/security_usecases.dart';
import '../../features/security/presentation/bloc/security_bloc.dart';
import '../../features/security/presentation/bloc/security_event.dart';
import '../../features/settings/data/datasources/settings_local_data_source.dart';
import '../../features/settings/data/datasources/settings_local_data_source_impl.dart';
import '../../features/settings/data/datasources/settings_remote_data_source.dart';
import '../../features/settings/data/datasources/settings_remote_data_source_impl.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/settings_usecases.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';
import '../../features/transactions/data/datasources/transactions_local_data_source.dart';
import '../../features/transactions/data/datasources/transactions_local_data_source_impl.dart';
import '../../features/transactions/data/datasources/transactions_remote_data_source.dart';
import '../../features/transactions/data/datasources/transactions_remote_data_source_impl.dart';
import '../../features/transactions/data/repositories/transactions_repository_impl.dart';
import '../../features/transactions/domain/repositories/transactions_repository.dart';
import '../../features/transactions/domain/usecases/transactions_usecases.dart';
import '../../features/transactions/presentation/bloc/transactions_bloc.dart';
import '../../features/transfer/data/datasources/transfer_local_data_source.dart';
import '../../features/transfer/data/datasources/transfer_local_data_source_impl.dart';
import '../../features/transfer/data/datasources/transfer_remote_data_source.dart';
import '../../features/transfer/data/datasources/transfer_remote_data_source_impl.dart';
import '../../features/transfer/data/repositories/transfer_repository_impl.dart';
import '../../features/transfer/domain/repositories/transfer_repository.dart';
import '../../features/transfer/domain/usecases/transfer_usecases.dart';
import '../../features/transfer/presentation/bloc/transfer_bloc.dart';
import '../../shared/data/api/banking_api_service.dart';
import '../ai/ai_cache_service.dart';
import '../ai/ai_orchestrator.dart';
import '../ai/context_manager.dart';
import '../ai/conversation_history_service.dart';
import '../ai/prompt_manager.dart';
import '../ai/providers/http_ai_provider.dart';
import '../ai/providers/mock_ai_provider.dart';
import '../ai/token_usage_monitor.dart';
import '../firebase/analytics_service.dart';
import '../firebase/push_notification_service.dart';
import '../network/api_client.dart';
import '../network/connectivity_service.dart';
import '../network/interceptors/error_interceptor.dart';
import '../network/interceptors/token_interceptor.dart';
import '../network/network_info.dart';
import '../offline/offline_sync_service.dart';
import '../pdf/pdf_service.dart';
import '../security/biometric_auth_service.dart';
import '../security/device_integrity_service.dart';
import '../security/jailbreak_detection_service.dart';
import '../security/pin_lock_service.dart';
import '../security/root_detection_service.dart';
import '../security/screenshot_protection_service.dart';
import '../security/secure_clipboard_service.dart';
import '../security/session_manager.dart';
import '../security/token_expiration_manager.dart';
import '../storage/cache_storage_service.dart';
import '../storage/secure_storage_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final cacheStorage = CacheStorageService();
  await cacheStorage.init();
  getIt.registerSingleton<CacheStorageService>(cacheStorage);

  getIt
    ..registerLazySingleton<SecureStorageService>(SecureStorageService.new)
    ..registerLazySingleton<ConnectivityService>(ConnectivityService.new)
    ..registerLazySingleton<NetworkInfo>(
      () => CachingNetworkInfo(NetworkInfoImpl(getIt<ConnectivityService>())),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(getIt<SecureStorageService>()),
    )
    ..registerLazySingleton<AuthRefreshClient>(AuthRefreshClient.new)
    ..registerLazySingleton<TokenInterceptor>(
      () => TokenInterceptor(
        getAccessToken: () => getIt<AuthLocalDataSource>().getAccessToken(),
        refreshToken: () async {
          final refresh = await getIt<AuthLocalDataSource>().getRefreshToken();
          if (refresh == null || refresh.isEmpty) return false;
          try {
            final tokens = await getIt<AuthRefreshClient>().refresh(refresh);
            await getIt<AuthLocalDataSource>().saveTokens(tokens);
            return true;
          } catch (_) {
            return false;
          }
        },
        onLogout: () => getIt<AuthLocalDataSource>().clearSession(),
      ),
    )
    ..registerLazySingleton<ErrorInterceptor>(ErrorInterceptor.new)
    ..registerLazySingleton<ApiClient>(
      () => ApiClient(
        tokenInterceptor: getIt<TokenInterceptor>(),
        errorInterceptor: getIt<ErrorInterceptor>(),
      ),
    )
    ..registerLazySingleton<BankingApiService>(
      () => BankingApiService(getIt<ApiClient>()),
    )
    ..registerLazySingleton<BiometricAuthService>(BiometricAuthService.new)
    ..registerLazySingleton<PinLockService>(
      () => PinLockService(getIt<SecureStorageService>()),
    )
    ..registerLazySingleton<SessionManager>(
      () => SessionManager(getIt<SecureStorageService>()),
    )
    ..registerLazySingleton<DeviceIntegrityChecker>(
      SafeDeviceIntegrityChecker.new,
    )
    ..registerLazySingleton<RootDetectionService>(
      () => RootDetectionServiceImpl(getIt<DeviceIntegrityChecker>()),
    )
    ..registerLazySingleton<JailbreakDetectionService>(
      () => JailbreakDetectionServiceImpl(getIt<DeviceIntegrityChecker>()),
    )
    ..registerLazySingleton<ScreenshotProtectionService>(
      ScreenshotProtectionService.new,
    )
    ..registerLazySingleton<SecureClipboardService>(SecureClipboardService.new)
    ..registerLazySingleton<TokenExpirationManager>(
      () => TokenExpirationManager(getIt<SecureStorageService>()),
    )
    ..registerLazySingleton<AnalyticsService>(AnalyticsService.new)
    ..registerLazySingleton<PushNotificationService>(
      PushNotificationService.new,
    )
    ..registerLazySingleton<BankStatementPdfGenerator>(
      BankStatementPdfGenerator.new,
    )
    ..registerLazySingleton<TransferReceiptPdfGenerator>(
      TransferReceiptPdfGenerator.new,
    )
    ..registerLazySingleton<PdfShareService>(PdfShareService.new);

  // Auth
  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt<BankingApiService>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remote: getIt<AuthRemoteDataSource>(),
        local: getIt<AuthLocalDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()))
    ..registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()))
    ..registerLazySingleton(() => RegisterUseCase(getIt<AuthRepository>()))
    ..registerLazySingleton(() => VerifyOtpUseCase(getIt<AuthRepository>()))
    ..registerLazySingleton(() => ResetPasswordUseCase(getIt<AuthRepository>()))
    ..registerFactory(
      () => AuthBloc(
        loginUseCase: getIt<LoginUseCase>(),
        logoutUseCase: getIt<LogoutUseCase>(),
        registerUseCase: getIt<RegisterUseCase>(),
        verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
        resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
      ),
    );

  // Dashboard
  getIt
    ..registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(
        getIt<BankingApiService>(),
        getIt<CacheStorageService>(),
      ),
    )
    ..registerLazySingleton<DashboardLocalDataSource>(
      () => DashboardLocalDataSourceImpl(getIt<CacheStorageService>()),
    )
    ..registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(
        local: getIt<DashboardLocalDataSource>(),
        remote: getIt<DashboardRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton(
      () => GetDashboardDataUseCase(getIt<DashboardRepository>()),
    )
    ..registerLazySingleton(
      () => GetAnalyticsDataUseCase(getIt<DashboardRepository>()),
    )
    ..registerFactory(
      () => DashboardBloc(
        getDashboardDataUseCase: getIt<GetDashboardDataUseCase>(),
        getAnalyticsDataUseCase: getIt<GetAnalyticsDataUseCase>(),
      ),
    );

  // Accounts
  getIt
    ..registerLazySingleton<AccountsRemoteDataSource>(
      () => AccountsRemoteDataSourceImpl(
        getIt<BankingApiService>(),
        getIt<CacheStorageService>(),
      ),
    )
    ..registerLazySingleton<AccountsLocalDataSource>(
      () => AccountsLocalDataSourceImpl(getIt<CacheStorageService>()),
    )
    ..registerLazySingleton<AccountsRepository>(
      () => AccountsRepositoryImpl(
        local: getIt<AccountsLocalDataSource>(),
        remote: getIt<AccountsRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton(
      () => GetAccountByIdUseCase(getIt<AccountsRepository>()),
    )
    ..registerFactory(
      () => AccountsBloc(getAccountByIdUseCase: getIt<GetAccountByIdUseCase>()),
    );

  // Transactions
  getIt
    ..registerLazySingleton<TransactionsRemoteDataSource>(
      () => TransactionsRemoteDataSourceImpl(
        getIt<BankingApiService>(),
        getIt<CacheStorageService>(),
      ),
    )
    ..registerLazySingleton<TransactionsLocalDataSource>(
      () => TransactionsLocalDataSourceImpl(getIt<CacheStorageService>()),
    )
    ..registerLazySingleton<TransactionsRepository>(
      () => TransactionsRepositoryImpl(
        local: getIt<TransactionsLocalDataSource>(),
        remote: getIt<TransactionsRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton(
      () => GetTransactionsUseCase(getIt<TransactionsRepository>()),
    )
    ..registerLazySingleton(
      () => GetTransactionByIdUseCase(getIt<TransactionsRepository>()),
    )
    ..registerFactory(
      () => TransactionsBloc(
        getTransactionsUseCase: getIt<GetTransactionsUseCase>(),
        getTransactionByIdUseCase: getIt<GetTransactionByIdUseCase>(),
      ),
    );

  // Transfer
  getIt
    ..registerLazySingleton<TransferRemoteDataSource>(
      () => TransferRemoteDataSourceImpl(
        getIt<BankingApiService>(),
        getIt<CacheStorageService>(),
      ),
    )
    ..registerLazySingleton<OfflineSyncService>(
      () => OfflineSyncService(
        cache: getIt<CacheStorageService>(),
        transferRemote: getIt<TransferRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
        connectivity: getIt<ConnectivityService>(),
      ),
    )
    ..registerLazySingleton<TransferLocalDataSource>(
      () => TransferLocalDataSourceImpl(getIt<CacheStorageService>()),
    )
    ..registerLazySingleton<TransferRepository>(
      () => TransferRepositoryImpl(
        local: getIt<TransferLocalDataSource>(),
        remote: getIt<TransferRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
        cache: getIt<CacheStorageService>(),
        offlineSync: getIt<OfflineSyncService>(),
      ),
    )
    ..registerLazySingleton(
      () => GetAccountsUseCase(getIt<TransferRepository>()),
    )
    ..registerLazySingleton(
      () => GetTransferBeneficiariesUseCase(getIt<TransferRepository>()),
    )
    ..registerLazySingleton(
      () => TransferMoneyUseCase(getIt<TransferRepository>()),
    )
    ..registerLazySingleton(
      () => AddBeneficiaryUseCase(getIt<TransferRepository>()),
    )
    ..registerFactory(
      () => TransferBloc(
        getAccountsUseCase: getIt<GetAccountsUseCase>(),
        getTransferBeneficiariesUseCase:
            getIt<GetTransferBeneficiariesUseCase>(),
        transferMoneyUseCase: getIt<TransferMoneyUseCase>(),
        addBeneficiaryUseCase: getIt<AddBeneficiaryUseCase>(),
      ),
    );

  // Cards
  getIt
    ..registerLazySingleton<CardsRemoteDataSource>(
      () => CardsRemoteDataSourceImpl(
        getIt<BankingApiService>(),
        getIt<CacheStorageService>(),
      ),
    )
    ..registerLazySingleton<CardsLocalDataSource>(
      () => CardsLocalDataSourceImpl(getIt<CacheStorageService>()),
    )
    ..registerLazySingleton<CardsRepository>(
      () => CardsRepositoryImpl(
        local: getIt<CardsLocalDataSource>(),
        remote: getIt<CardsRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton(() => GetCardsUseCase(getIt<CardsRepository>()))
    ..registerLazySingleton(() => GetCardByIdUseCase(getIt<CardsRepository>()))
    ..registerLazySingleton(
      () => ToggleCardFreezeUseCase(getIt<CardsRepository>()),
    )
    ..registerFactory(
      () => CardsBloc(
        getCardsUseCase: getIt<GetCardsUseCase>(),
        getCardByIdUseCase: getIt<GetCardByIdUseCase>(),
        toggleCardFreezeUseCase: getIt<ToggleCardFreezeUseCase>(),
      ),
    );

  // Payments
  getIt
    ..registerLazySingleton<PaymentsRemoteDataSource>(
      () => PaymentsRemoteDataSourceImpl(
        getIt<BankingApiService>(),
        getIt<CacheStorageService>(),
      ),
    )
    ..registerLazySingleton<PaymentsLocalDataSource>(
      () => PaymentsLocalDataSourceImpl(getIt<CacheStorageService>()),
    )
    ..registerLazySingleton<PaymentsRepository>(
      () => PaymentsRepositoryImpl(
        local: getIt<PaymentsLocalDataSource>(),
        remote: getIt<PaymentsRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton(
      () => GetQrPaymentDataUseCase(getIt<PaymentsRepository>()),
    )
    ..registerLazySingleton(
      () => SubmitBillPaymentUseCase(getIt<PaymentsRepository>()),
    )
    ..registerFactory(
      () => PaymentsBloc(
        getQrPaymentDataUseCase: getIt<GetQrPaymentDataUseCase>(),
        submitBillPaymentUseCase: getIt<SubmitBillPaymentUseCase>(),
      ),
    );

  // Notifications
  getIt
    ..registerLazySingleton<NotificationsRemoteDataSource>(
      () => NotificationsRemoteDataSourceImpl(
        getIt<BankingApiService>(),
        getIt<CacheStorageService>(),
      ),
    )
    ..registerLazySingleton<NotificationsLocalDataSource>(
      () => NotificationsLocalDataSourceImpl(getIt<CacheStorageService>()),
    )
    ..registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(
        local: getIt<NotificationsLocalDataSource>(),
        remote: getIt<NotificationsRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton(
      () => GetNotificationsUseCase(getIt<NotificationsRepository>()),
    )
    ..registerLazySingleton(
      () => MarkNotificationReadUseCase(getIt<NotificationsRepository>()),
    )
    ..registerFactory(
      () => NotificationsBloc(
        getNotificationsUseCase: getIt<GetNotificationsUseCase>(),
        markNotificationReadUseCase: getIt<MarkNotificationReadUseCase>(),
      ),
    );

  // Profile
  getIt
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(
        getIt<BankingApiService>(),
        getIt<CacheStorageService>(),
      ),
    )
    ..registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(getIt<CacheStorageService>()),
    )
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        local: getIt<ProfileLocalDataSource>(),
        remote: getIt<ProfileRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton(
      () => GetProfileDataUseCase(getIt<ProfileRepository>()),
    )
    ..registerFactory(
      () => ProfileBloc(getProfileDataUseCase: getIt<GetProfileDataUseCase>()),
    );

  // Settings
  getIt
    ..registerLazySingleton<SettingsRemoteDataSource>(
      () => SettingsRemoteDataSourceImpl(
        getIt<BankingApiService>(),
        getIt<CacheStorageService>(),
      ),
    )
    ..registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(getIt<CacheStorageService>()),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        local: getIt<SettingsLocalDataSource>(),
        remote: getIt<SettingsRemoteDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton(
      () => GetSettingsUseCase(getIt<SettingsRepository>()),
    )
    ..registerLazySingleton(
      () => SetThemeModeUseCase(getIt<SettingsRepository>()),
    )
    ..registerLazySingleton(() => SetLocaleUseCase(getIt<SettingsRepository>()))
    ..registerLazySingleton<SettingsBloc>(
      () => SettingsBloc(
        getSettingsUseCase: getIt<GetSettingsUseCase>(),
        setThemeModeUseCase: getIt<SetThemeModeUseCase>(),
        setLocaleUseCase: getIt<SetLocaleUseCase>(),
      ),
    );

  // AI Platform
  getIt
    ..registerLazySingleton<PromptManager>(PromptManager.new)
    ..registerLazySingleton<AiContextManager>(AiContextManager.new)
    ..registerLazySingleton<TokenUsageMonitor>(TokenUsageMonitor.new)
    ..registerLazySingleton<AiCacheService>(
      () => AiCacheService(getIt<CacheStorageService>()),
    )
    ..registerLazySingleton<ConversationHistoryService>(
      () => ConversationHistoryService(getIt<SecureStorageService>()),
    )
    ..registerLazySingleton<MockAiProvider>(MockAiProvider.new)
    ..registerLazySingleton<HttpAiProvider>(HttpAiProvider.new)
    ..registerLazySingleton<AiOrchestrator>(
      () => AiOrchestrator(
        mockProvider: getIt<MockAiProvider>(),
        httpProvider: getIt<HttpAiProvider>(),
        cache: getIt<AiCacheService>(),
        history: getIt<ConversationHistoryService>(),
        tokenMonitor: getIt<TokenUsageMonitor>(),
        promptManager: getIt<PromptManager>(),
        contextManager: getIt<AiContextManager>(),
      ),
    )
    ..registerLazySingleton<AiRepository>(
      () => AiRepositoryImpl(
        orchestrator: getIt<AiOrchestrator>(),
        transactionsRepository: getIt<TransactionsRepository>(),
        cache: getIt<CacheStorageService>(),
      ),
    )
    ..registerLazySingleton(() => ChatUseCase(getIt<AiRepository>()))
    ..registerLazySingleton(
      () => ClearChatHistoryUseCase(getIt<AiRepository>()),
    )
    ..registerLazySingleton(
      () => GetSpendingAnalysisUseCase(getIt<AiRepository>()),
    )
    ..registerLazySingleton(() => GetBudgetsUseCase(getIt<AiRepository>()))
    ..registerLazySingleton(() => UpdateBudgetUseCase(getIt<AiRepository>()))
    ..registerLazySingleton(
      () => GetExpensePredictionUseCase(getIt<AiRepository>()),
    )
    ..registerLazySingleton(
      () => GetPersonalizedInsightsUseCase(getIt<AiRepository>()),
    )
    ..registerLazySingleton(() => GetSmartAlertsUseCase(getIt<AiRepository>()))
    ..registerLazySingleton(() => SmartSearchUseCase(getIt<AiRepository>()))
    ..registerLazySingleton(() => ParseReceiptUseCase(getIt<AiRepository>()))
    ..registerLazySingleton(
      () => ParseVoiceCommandUseCase(getIt<AiRepository>()),
    )
    ..registerLazySingleton(() => GetCurrenciesUseCase(getIt<AiRepository>()))
    ..registerLazySingleton(() => ConvertCurrencyUseCase(getIt<AiRepository>()))
    ..registerLazySingleton(() => GetInvestmentsUseCase(getIt<AiRepository>()))
    ..registerFactory(
      () => AiAssistantBloc(
        chatUseCase: getIt<ChatUseCase>(),
        clearChatHistoryUseCase: getIt<ClearChatHistoryUseCase>(),
      ),
    )
    ..registerFactory(
      () => AiFinanceBloc(
        spendingAnalysisUseCase: getIt<GetSpendingAnalysisUseCase>(),
        budgetsUseCase: getIt<GetBudgetsUseCase>(),
        updateBudgetUseCase: getIt<UpdateBudgetUseCase>(),
        predictionUseCase: getIt<GetExpensePredictionUseCase>(),
        insightsUseCase: getIt<GetPersonalizedInsightsUseCase>(),
        alertsUseCase: getIt<GetSmartAlertsUseCase>(),
      ),
    );

  // Security
  getIt
    ..registerLazySingleton<SecurityRepository>(
      () => SecurityRepositoryImpl(
        biometricAuth: getIt<BiometricAuthService>(),
        pinLock: getIt<PinLockService>(),
        secureStorage: getIt<SecureStorageService>(),
        deviceIntegrity: getIt<DeviceIntegrityChecker>(),
        rootDetection: getIt<RootDetectionService>(),
        jailbreakDetection: getIt<JailbreakDetectionService>(),
      ),
    )
    ..registerLazySingleton(
      () => LoadSecuritySettingsUseCase(getIt<SecurityRepository>()),
    )
    ..registerLazySingleton(
      () => ToggleBiometricUseCase(getIt<SecurityRepository>()),
    )
    ..registerLazySingleton(
      () => BiometricLoginUseCase(getIt<SecurityRepository>()),
    )
    ..registerFactory(
      () => SecurityBloc(
        loadSecuritySettingsUseCase: getIt<LoadSecuritySettingsUseCase>(),
        toggleBiometricUseCase: getIt<ToggleBiometricUseCase>(),
      )..add(const SecuritySettingsLoaded()),
    );

  // Offline sync + session init deferred via StartupScheduler after first frame.
}

/// Resets GetIt between tests for integration/widget isolation.
Future<void> resetDependencies() async {
  await getIt.reset();
}
