// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banking_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthTokensDto _$AuthTokensDtoFromJson(Map<String, dynamic> json) =>
    _AuthTokensDto(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$AuthTokensDtoToJson(_AuthTokensDto instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };

_LoginRequestDto _$LoginRequestDtoFromJson(Map<String, dynamic> json) =>
    _LoginRequestDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestDtoToJson(_LoginRequestDto instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_RegisterRequestDto _$RegisterRequestDtoFromJson(Map<String, dynamic> json) =>
    _RegisterRequestDto(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterRequestDtoToJson(_RegisterRequestDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };

_AuthResponseDto _$AuthResponseDtoFromJson(Map<String, dynamic> json) =>
    _AuthResponseDto(
      tokens: AuthTokensDto.fromJson(json['tokens'] as Map<String, dynamic>),
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseDtoToJson(_AuthResponseDto instance) =>
    <String, dynamic>{'tokens': instance.tokens, 'user': instance.user};

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
};

_ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => _ProfileDto(
  user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
  cardCount: (json['card_count'] as num).toInt(),
  phone: json['phone'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  memberSince: json['member_since'] as String?,
);

Map<String, dynamic> _$ProfileDtoToJson(_ProfileDto instance) =>
    <String, dynamic>{
      'user': instance.user,
      'card_count': instance.cardCount,
      'phone': instance.phone,
      'avatar_url': instance.avatarUrl,
      'member_since': instance.memberSince,
    };

_AccountDto _$AccountDtoFromJson(Map<String, dynamic> json) => _AccountDto(
  id: json['id'] as String,
  name: json['name'] as String,
  accountNumber: json['account_number'] as String,
  iban: json['iban'] as String,
  balance: (json['balance'] as num).toDouble(),
  currency: json['currency'] as String,
  type: json['type'] as String,
  color: (json['color'] as num).toInt(),
);

Map<String, dynamic> _$AccountDtoToJson(_AccountDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account_number': instance.accountNumber,
      'iban': instance.iban,
      'balance': instance.balance,
      'currency': instance.currency,
      'type': instance.type,
      'color': instance.color,
    };

_TransactionDto _$TransactionDtoFromJson(Map<String, dynamic> json) =>
    _TransactionDto(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      date: json['date'] as String,
      category: json['category'] as String,
      icon: json['icon'] as String,
      reference: json['reference'] as String,
      accountId: json['account_id'] as String,
    );

Map<String, dynamic> _$TransactionDtoToJson(_TransactionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'amount': instance.amount,
      'currency': instance.currency,
      'type': instance.type,
      'status': instance.status,
      'date': instance.date,
      'category': instance.category,
      'icon': instance.icon,
      'reference': instance.reference,
      'account_id': instance.accountId,
    };

_BeneficiaryDto _$BeneficiaryDtoFromJson(Map<String, dynamic> json) =>
    _BeneficiaryDto(
      id: json['id'] as String,
      name: json['name'] as String,
      bankName: json['bank_name'] as String,
      accountNumber: json['account_number'] as String,
      avatarInitials: json['avatar_initials'] as String,
      color: (json['color'] as num).toInt(),
    );

Map<String, dynamic> _$BeneficiaryDtoToJson(_BeneficiaryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bank_name': instance.bankName,
      'account_number': instance.accountNumber,
      'avatar_initials': instance.avatarInitials,
      'color': instance.color,
    };

_TransferRequestDto _$TransferRequestDtoFromJson(Map<String, dynamic> json) =>
    _TransferRequestDto(
      fromAccountId: json['from_account_id'] as String,
      beneficiaryId: json['beneficiary_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$TransferRequestDtoToJson(_TransferRequestDto instance) =>
    <String, dynamic>{
      'from_account_id': instance.fromAccountId,
      'beneficiary_id': instance.beneficiaryId,
      'amount': instance.amount,
      'note': instance.note,
    };

_CardDto _$CardDtoFromJson(Map<String, dynamic> json) => _CardDto(
  id: json['id'] as String,
  cardNumber: json['card_number'] as String,
  holderName: json['holder_name'] as String,
  expiryDate: json['expiry_date'] as String,
  cvv: json['cvv'] as String,
  type: json['type'] as String,
  status: json['status'] as String,
  balance: (json['balance'] as num).toDouble(),
  currency: json['currency'] as String,
  gradientColors: (json['gradient_colors'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$CardDtoToJson(_CardDto instance) => <String, dynamic>{
  'id': instance.id,
  'card_number': instance.cardNumber,
  'holder_name': instance.holderName,
  'expiry_date': instance.expiryDate,
  'cvv': instance.cvv,
  'type': instance.type,
  'status': instance.status,
  'balance': instance.balance,
  'currency': instance.currency,
  'gradient_colors': instance.gradientColors,
};

_NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    _NotificationDto(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      time: json['time'] as String,
      isRead: json['is_read'] as bool,
      icon: json['icon'] as String,
      color: (json['color'] as num).toInt(),
    );

Map<String, dynamic> _$NotificationDtoToJson(_NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'time': instance.time,
      'is_read': instance.isRead,
      'icon': instance.icon,
      'color': instance.color,
    };

_DashboardDto _$DashboardDtoFromJson(Map<String, dynamic> json) =>
    _DashboardDto(
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      totalBalance: (json['total_balance'] as num).toDouble(),
      accounts: (json['accounts'] as List<dynamic>)
          .map((e) => AccountDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentTransactions: (json['recent_transactions'] as List<dynamic>)
          .map((e) => TransactionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      weeklySpending: (json['weekly_spending'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      weeklyLabels: (json['weekly_labels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DashboardDtoToJson(_DashboardDto instance) =>
    <String, dynamic>{
      'user': instance.user,
      'total_balance': instance.totalBalance,
      'accounts': instance.accounts,
      'recent_transactions': instance.recentTransactions,
      'weekly_spending': instance.weeklySpending,
      'weekly_labels': instance.weeklyLabels,
    };

_AnalyticsDto _$AnalyticsDtoFromJson(Map<String, dynamic> json) =>
    _AnalyticsDto(
      weeklySpending: (json['weekly_spending'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      weeklyLabels: (json['weekly_labels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      totalIncome: (json['total_income'] as num).toDouble(),
      totalExpense: (json['total_expense'] as num).toDouble(),
    );

Map<String, dynamic> _$AnalyticsDtoToJson(_AnalyticsDto instance) =>
    <String, dynamic>{
      'weekly_spending': instance.weeklySpending,
      'weekly_labels': instance.weeklyLabels,
      'total_income': instance.totalIncome,
      'total_expense': instance.totalExpense,
    };

_QrPaymentDto _$QrPaymentDtoFromJson(Map<String, dynamic> json) =>
    _QrPaymentDto(
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      accountName: json['account_name'] as String,
      accountNumber: json['account_number'] as String,
      iban: json['iban'] as String,
      qrPayload: json['qr_payload'] as String?,
    );

Map<String, dynamic> _$QrPaymentDtoToJson(_QrPaymentDto instance) =>
    <String, dynamic>{
      'user': instance.user,
      'account_name': instance.accountName,
      'account_number': instance.accountNumber,
      'iban': instance.iban,
      'qr_payload': instance.qrPayload,
    };

_BillPaymentRequestDto _$BillPaymentRequestDtoFromJson(
  Map<String, dynamic> json,
) => _BillPaymentRequestDto(
  amount: (json['amount'] as num).toDouble(),
  billType: json['bill_type'] as String,
);

Map<String, dynamic> _$BillPaymentRequestDtoToJson(
  _BillPaymentRequestDto instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'bill_type': instance.billType,
};

_SettingsDto _$SettingsDtoFromJson(Map<String, dynamic> json) => _SettingsDto(
  themeMode: json['theme_mode'] as String,
  locale: json['locale'] as String,
);

Map<String, dynamic> _$SettingsDtoToJson(_SettingsDto instance) =>
    <String, dynamic>{
      'theme_mode': instance.themeMode,
      'locale': instance.locale,
    };
