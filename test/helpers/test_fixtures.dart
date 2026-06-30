import 'package:bankx/features/dashboard/domain/usecases/dashboard_usecases.dart';
import 'package:bankx/features/payments/domain/usecases/payments_usecases.dart';
import 'package:bankx/features/profile/domain/usecases/profile_usecases.dart';
import 'package:bankx/features/settings/domain/repositories/settings_repository.dart';
import 'package:bankx/shared/data/dto/banking_dtos.dart';
import 'package:bankx/shared/domain/entities/account.dart';
import 'package:bankx/shared/domain/entities/beneficiary.dart';
import 'package:bankx/shared/domain/entities/card_model.dart';
import 'package:bankx/shared/domain/entities/notification_model.dart';
import 'package:bankx/shared/domain/entities/transaction.dart';
import 'package:bankx/shared/domain/entities/user.dart';
import 'package:flutter/material.dart';

/// Canonical test entities and DTOs used across unit, bloc, and widget tests.
abstract final class TestFixtures {
  static final user = UserProfile(
    id: 'user-1',
    name: 'Ahmed Mohammed',
    email: 'ahmed@bankx.com',
    phone: '+971500000000',
    avatarUrl: '',
    memberSince: DateTime(2024, 1, 1),
  );

  static const account = BankAccount(
    id: 'acc-1',
    name: 'Main Account',
    accountNumber: '1234567890',
    iban: 'AE070331234567890123456',
    balance: 25000,
    currency: 'AED',
    type: 'current',
    color: 0xFF1E3A8A,
  );

  static final transaction = Transaction(
    id: 'tx-1',
    title: 'Salary',
    subtitle: 'Employer',
    amount: 15000,
    currency: 'AED',
    type: TransactionType.income,
    status: TransactionStatus.completed,
    date: DateTime(2024, 6, 1),
    category: 'income',
    icon: 'payments',
    reference: 'REF-001',
    accountId: 'acc-1',
  );

  static const card = BankCard(
    id: 'card-1',
    cardNumber: '**** **** **** 4242',
    holderName: 'Ahmed Mohammed',
    expiryDate: '12/28',
    cvv: '***',
    type: CardType.physical,
    status: CardStatus.active,
    balance: 5000,
    currency: 'AED',
    gradientColors: [0xFF1E3A8A, 0xFF3B82F6],
  );

  static const beneficiary = Beneficiary(
    id: 'ben-1',
    name: 'Sara Ali',
    bankName: 'BankX',
    accountNumber: '9876543210',
    avatarInitials: 'SA',
    color: 0xFF059669,
  );

  static final notification = AppNotification(
    id: 'notif-1',
    title: 'Transfer received',
    body: 'You received AED 500',
    time: DateTime(2024, 6, 15),
    isRead: false,
    icon: 'notifications',
    color: 0xFF2563EB,
  );

  static DashboardData get dashboardData => DashboardData(
    user: user,
    totalBalance: 25000,
    accounts: [account],
    recentTransactions: [transaction],
    weeklySpending: const [100, 200, 150, 300, 250, 180, 220],
    weeklyLabels: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  );

  static AnalyticsData get analyticsData => const AnalyticsData(
    weeklySpending: [100, 200, 150, 300, 250, 180, 220],
    weeklyLabels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    totalIncome: 20000,
    totalExpense: 8000,
  );

  static ProfileData get profileData => ProfileData(user: user, cardCount: 2);

  static QrPaymentData get qrPaymentData => QrPaymentData(
    user: user,
    accountName: account.name,
    accountNumber: account.accountNumber,
    iban: account.iban,
  );

  static SettingsBundle get settingsBundle =>
      const SettingsBundle(themeMode: ThemeMode.light, locale: Locale('en'));

  static AuthResponseDto get authResponse => AuthResponseDto(
    tokens: const AuthTokensDto(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
    ),
    user: UserDto(id: user.id, name: user.name, email: user.email),
  );
}
