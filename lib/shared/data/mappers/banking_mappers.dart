import '../../../features/dashboard/domain/usecases/dashboard_usecases.dart';
import '../../../features/payments/domain/usecases/payments_usecases.dart';
import '../../../features/profile/domain/usecases/profile_usecases.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/beneficiary.dart';
import '../../domain/entities/card_model.dart';
import '../../domain/entities/notification_model.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/user.dart';
import '../dto/banking_dtos.dart';

/// Maps JSON DTOs to domain entities — keeps domain free of serialization.
abstract final class BankingMappers {
  static UserProfile toUser(UserDto dto) => UserProfile(
    id: dto.id,
    name: dto.name,
    email: dto.email,
    phone: '',
    avatarUrl: '',
    memberSince: DateTime.now(),
  );

  static UserProfile toUserFromProfile(ProfileDto dto) => UserProfile(
    id: dto.user.id,
    name: dto.user.name,
    email: dto.user.email,
    phone: dto.phone ?? '',
    avatarUrl: dto.avatarUrl ?? '',
    memberSince: dto.memberSince != null
        ? DateTime.tryParse(dto.memberSince!) ?? DateTime.now()
        : DateTime.now(),
  );

  static BankAccount toAccount(AccountDto dto) => BankAccount(
    id: dto.id,
    name: dto.name,
    accountNumber: dto.accountNumber,
    iban: dto.iban,
    balance: dto.balance,
    currency: dto.currency,
    type: dto.type,
    color: dto.color,
  );

  static Transaction toTransaction(TransactionDto dto) => Transaction(
    id: dto.id,
    title: dto.title,
    subtitle: dto.subtitle,
    amount: dto.amount,
    currency: dto.currency,
    type: dto.type == 'income'
        ? TransactionType.income
        : TransactionType.expense,
    status: _mapTxStatus(dto.status),
    date: DateTime.tryParse(dto.date) ?? DateTime.now(),
    category: dto.category,
    icon: dto.icon,
    reference: dto.reference,
    accountId: dto.accountId,
  );

  static TransactionStatus _mapTxStatus(String status) =>
      switch (status.toLowerCase()) {
        'pending' => TransactionStatus.pending,
        'failed' => TransactionStatus.failed,
        _ => TransactionStatus.completed,
      };

  static Beneficiary toBeneficiary(BeneficiaryDto dto) => Beneficiary(
    id: dto.id,
    name: dto.name,
    bankName: dto.bankName,
    accountNumber: dto.accountNumber,
    avatarInitials: dto.avatarInitials,
    color: dto.color,
  );

  static BankCard toCard(CardDto dto) => BankCard(
    id: dto.id,
    cardNumber: dto.cardNumber,
    holderName: dto.holderName,
    expiryDate: dto.expiryDate,
    cvv: dto.cvv,
    type: dto.type == 'virtual' ? CardType.virtual : CardType.physical,
    status: dto.status == 'frozen' ? CardStatus.frozen : CardStatus.active,
    balance: dto.balance,
    currency: dto.currency,
    gradientColors: dto.gradientColors,
  );

  static AppNotification toNotification(NotificationDto dto) => AppNotification(
    id: dto.id,
    title: dto.title,
    body: dto.body,
    time: DateTime.tryParse(dto.time) ?? DateTime.now(),
    isRead: dto.isRead,
    icon: dto.icon,
    color: dto.color,
  );

  static DashboardData toDashboard(DashboardDto dto) => DashboardData(
    user: toUser(dto.user),
    totalBalance: dto.totalBalance,
    accounts: dto.accounts.map(toAccount).toList(),
    recentTransactions: dto.recentTransactions.map(toTransaction).toList(),
    weeklySpending: dto.weeklySpending,
    weeklyLabels: dto.weeklyLabels,
  );

  static AnalyticsData toAnalytics(AnalyticsDto dto) => AnalyticsData(
    weeklySpending: dto.weeklySpending,
    weeklyLabels: dto.weeklyLabels,
    totalIncome: dto.totalIncome,
    totalExpense: dto.totalExpense,
  );

  static ProfileData toProfile(ProfileDto dto) =>
      ProfileData(user: toUserFromProfile(dto), cardCount: dto.cardCount);

  static QrPaymentData toQrPayment(QrPaymentDto dto) => QrPaymentData(
    user: toUser(dto.user),
    accountName: dto.accountName,
    accountNumber: dto.accountNumber,
    iban: dto.iban,
  );
}
