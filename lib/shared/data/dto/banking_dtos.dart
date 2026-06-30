import 'package:freezed_annotation/freezed_annotation.dart';

part 'banking_dtos.freezed.dart';
part 'banking_dtos.g.dart';

// ── Auth ──────────────────────────────────────────────────────────────────────

@freezed
abstract class AuthTokensDto with _$AuthTokensDto {
  const factory AuthTokensDto({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _AuthTokensDto;

  factory AuthTokensDto.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensDtoFromJson(json);
}

@freezed
abstract class LoginRequestDto with _$LoginRequestDto {
  const factory LoginRequestDto({
    required String email,
    required String password,
  }) = _LoginRequestDto;

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);
}

@freezed
abstract class RegisterRequestDto with _$RegisterRequestDto {
  const factory RegisterRequestDto({
    required String name,
    required String email,
    required String password,
  }) = _RegisterRequestDto;

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDtoFromJson(json);
}

@freezed
abstract class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    required AuthTokensDto tokens,
    required UserDto user,
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);
}

// ── User / Profile ────────────────────────────────────────────────────────────

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String name,
    required String email,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

@freezed
abstract class ProfileDto with _$ProfileDto {
  const factory ProfileDto({
    required UserDto user,
    @JsonKey(name: 'card_count') required int cardCount,
    String? phone,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'member_since') String? memberSince,
  }) = _ProfileDto;

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);
}

// ── Account ───────────────────────────────────────────────────────────────────

@freezed
abstract class AccountDto with _$AccountDto {
  const factory AccountDto({
    required String id,
    required String name,
    @JsonKey(name: 'account_number') required String accountNumber,
    required String iban,
    required double balance,
    required String currency,
    required String type,
    required int color,
  }) = _AccountDto;

  factory AccountDto.fromJson(Map<String, dynamic> json) =>
      _$AccountDtoFromJson(json);
}

// ── Transaction ───────────────────────────────────────────────────────────────

@freezed
abstract class TransactionDto with _$TransactionDto {
  const factory TransactionDto({
    required String id,
    required String title,
    required String subtitle,
    required double amount,
    required String currency,
    required String type,
    required String status,
    required String date,
    required String category,
    required String icon,
    required String reference,
    @JsonKey(name: 'account_id') required String accountId,
  }) = _TransactionDto;

  factory TransactionDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionDtoFromJson(json);
}

// ── Beneficiary ───────────────────────────────────────────────────────────────

@freezed
abstract class BeneficiaryDto with _$BeneficiaryDto {
  const factory BeneficiaryDto({
    required String id,
    required String name,
    @JsonKey(name: 'bank_name') required String bankName,
    @JsonKey(name: 'account_number') required String accountNumber,
    @JsonKey(name: 'avatar_initials') required String avatarInitials,
    required int color,
  }) = _BeneficiaryDto;

  factory BeneficiaryDto.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryDtoFromJson(json);
}

// ── Transfer ──────────────────────────────────────────────────────────────────

@freezed
abstract class TransferRequestDto with _$TransferRequestDto {
  const factory TransferRequestDto({
    @JsonKey(name: 'from_account_id') required String fromAccountId,
    @JsonKey(name: 'beneficiary_id') required String beneficiaryId,
    required double amount,
    String? note,
  }) = _TransferRequestDto;

  factory TransferRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TransferRequestDtoFromJson(json);
}

// ── Card ──────────────────────────────────────────────────────────────────────

@freezed
abstract class CardDto with _$CardDto {
  const factory CardDto({
    required String id,
    @JsonKey(name: 'card_number') required String cardNumber,
    @JsonKey(name: 'holder_name') required String holderName,
    @JsonKey(name: 'expiry_date') required String expiryDate,
    required String cvv,
    required String type,
    required String status,
    required double balance,
    required String currency,
    @JsonKey(name: 'gradient_colors') required List<int> gradientColors,
  }) = _CardDto;

  factory CardDto.fromJson(Map<String, dynamic> json) =>
      _$CardDtoFromJson(json);
}

// ── Notification ──────────────────────────────────────────────────────────────

@freezed
abstract class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    required String id,
    required String title,
    required String body,
    required String time,
    @JsonKey(name: 'is_read') required bool isRead,
    required String icon,
    required int color,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}

// ── Dashboard / Analytics ─────────────────────────────────────────────────────

@freezed
abstract class DashboardDto with _$DashboardDto {
  const factory DashboardDto({
    required UserDto user,
    @JsonKey(name: 'total_balance') required double totalBalance,
    required List<AccountDto> accounts,
    @JsonKey(name: 'recent_transactions')
    required List<TransactionDto> recentTransactions,
    @JsonKey(name: 'weekly_spending') required List<double> weeklySpending,
    @JsonKey(name: 'weekly_labels') required List<String> weeklyLabels,
  }) = _DashboardDto;

  factory DashboardDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardDtoFromJson(json);
}

@freezed
abstract class AnalyticsDto with _$AnalyticsDto {
  const factory AnalyticsDto({
    @JsonKey(name: 'weekly_spending') required List<double> weeklySpending,
    @JsonKey(name: 'weekly_labels') required List<String> weeklyLabels,
    @JsonKey(name: 'total_income') required double totalIncome,
    @JsonKey(name: 'total_expense') required double totalExpense,
  }) = _AnalyticsDto;

  factory AnalyticsDto.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsDtoFromJson(json);
}

// ── Payments ──────────────────────────────────────────────────────────────────

@freezed
abstract class QrPaymentDto with _$QrPaymentDto {
  const factory QrPaymentDto({
    required UserDto user,
    @JsonKey(name: 'account_name') required String accountName,
    @JsonKey(name: 'account_number') required String accountNumber,
    required String iban,
    @JsonKey(name: 'qr_payload') String? qrPayload,
  }) = _QrPaymentDto;

  factory QrPaymentDto.fromJson(Map<String, dynamic> json) =>
      _$QrPaymentDtoFromJson(json);
}

@freezed
abstract class BillPaymentRequestDto with _$BillPaymentRequestDto {
  const factory BillPaymentRequestDto({
    required double amount,
    @JsonKey(name: 'bill_type') required String billType,
  }) = _BillPaymentRequestDto;

  factory BillPaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$BillPaymentRequestDtoFromJson(json);
}

// ── Settings ──────────────────────────────────────────────────────────────────

@freezed
abstract class SettingsDto with _$SettingsDto {
  const factory SettingsDto({
    @JsonKey(name: 'theme_mode') required String themeMode,
    required String locale,
  }) = _SettingsDto;

  factory SettingsDto.fromJson(Map<String, dynamic> json) =>
      _$SettingsDtoFromJson(json);
}
