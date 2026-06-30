# BankX API Reference

REST API consumed by the BankX mobile client.

**Base URL:** Configured via `BANKX_API_BASE_URL` dart-define (default: `https://api.bankx.com/v1`)

**Authentication:** Bearer JWT in `Authorization` header (attached by `TokenInterceptor`)

**Content-Type:** `application/json`

**Error response format:**

```json
{
  "message": "Human-readable error description",
  "error": "ERROR_CODE"
}
```

---

## Common Status Codes

| Code | Meaning | Client handling |
|------|---------|-----------------|
| 200 | Success | Parse response body |
| 201 | Created | Parse response body |
| 204 | No content | Success, empty body |
| 400 | Bad request | `ServerException` |
| 401 | Unauthorized | Silent token refresh or logout |
| 403 | Forbidden | `ForbiddenException` |
| 404 | Not found | `NotFoundException` |
| 408 | Timeout | `ApiTimeoutException` |
| 409 | Conflict | `ConflictException` |
| 422 | Validation error | `ValidationException` |
| 429 | Rate limited | `TooManyRequestsException` |
| 500+ | Server error | `ServerException` |

---

## Authentication

### POST `/auth/login`

Authenticate with email and password.

**Request:**

```json
{
  "email": "user@example.com",
  "password": "SecurePass123!"
}
```

**Response `200`:**

```json
{
  "tokens": {
    "access_token": "eyJhbGciOiJIUzI1NiIs...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIs..."
  },
  "user": {
    "id": "usr_001",
    "name": "Ahmed Mohammed",
    "email": "user@example.com"
  }
}
```

**Error `401`:**

```json
{
  "message": "Invalid email or password"
}
```

---

### POST `/auth/register`

Create a new account.

**Request:**

```json
{
  "name": "Ahmed Mohammed",
  "email": "user@example.com",
  "password": "SecurePass123!"
}
```

**Response `201`:** Same shape as login response.

**Error `409`:**

```json
{
  "message": "Email already registered"
}
```

---

### POST `/auth/refresh`

Refresh access token.

**Request:**

```json
{
  "refresh_token": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Response `200`:**

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Error `401`:**

```json
{
  "message": "Refresh token expired"
}
```

---

### POST `/auth/logout`

Invalidate current session.

**Headers:** `Authorization: Bearer <access_token>`

**Response `204`:** No body.

---

### POST `/auth/forgot-password`

Request password reset email.

**Request:**

```json
{
  "email": "user@example.com"
}
```

**Response `204`:** No body (always returns success to prevent email enumeration).

---

### POST `/auth/verify-otp`

Verify one-time password.

**Request:**

```json
{
  "code": "123456"
}
```

**Response `200`:** Same shape as login response.

**Error `422`:**

```json
{
  "message": "Invalid or expired OTP code"
}
```

---

### POST `/auth/reset-password`

Reset password with token.

**Request:**

```json
{
  "email": "user@example.com",
  "password": "NewSecurePass456!",
  "token": "reset_token_from_email"
}
```

**Response `204`:** No body.

---

## Dashboard

### GET `/dashboard`

Home screen aggregate data.

**Headers:** `Authorization: Bearer <access_token>`

**Response `200`:**

```json
{
  "user": { "id": "usr_001", "name": "Ahmed", "email": "user@example.com" },
  "total_balance": 45230.50,
  "accounts": [
    {
      "id": "acc_001",
      "name": "Primary Checking",
      "account_number": "****4521",
      "iban": "AE070331234567890123456",
      "balance": 32500.00,
      "currency": "AED",
      "type": "checking",
      "color": 4280391411
    }
  ],
  "recent_transactions": [
    {
      "id": "txn_001",
      "title": "Salary Deposit",
      "subtitle": "Employer Inc.",
      "amount": 15000.00,
      "currency": "AED",
      "type": "credit",
      "status": "completed",
      "date": "2026-06-25",
      "category": "income",
      "icon": "payments",
      "reference": "REF-20260625-001",
      "account_id": "acc_001"
    }
  ],
  "weekly_spending": [120.0, 85.5, 200.0, 45.0, 310.0, 90.0, 150.0],
  "weekly_labels": ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
}
```

---

### GET `/dashboard/analytics`

Spending analytics for the analytics tab.

**Response `200`:**

```json
{
  "weekly_spending": [120.0, 85.5, 200.0, 45.0, 310.0, 90.0, 150.0],
  "weekly_labels": ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  "total_income": 18500.00,
  "total_expense": 1000.50
}
```

---

## Accounts

### GET `/accounts/{id}`

Account details by ID.

**Response `200`:**

```json
{
  "id": "acc_001",
  "name": "Primary Checking",
  "account_number": "****4521",
  "iban": "AE070331234567890123456",
  "balance": 32500.00,
  "currency": "AED",
  "type": "checking",
  "color": 4280391411
}
```

**Error `404`:**

```json
{
  "message": "Account not found"
}
```

---

## Transactions

### GET `/transactions`

List transactions. Optional filter by type.

**Query parameters:**

| Param | Type | Description |
|-------|------|-------------|
| `type` | string | `credit` or `debit` (optional) |

**Response `200`:**

```json
[
  {
    "id": "txn_001",
    "title": "Salary Deposit",
    "subtitle": "Employer Inc.",
    "amount": 15000.00,
    "currency": "AED",
    "type": "credit",
    "status": "completed",
    "date": "2026-06-25",
    "category": "income",
    "icon": "payments",
    "reference": "REF-20260625-001",
    "account_id": "acc_001"
  }
]
```

---

### GET `/transactions/{id}`

Single transaction details.

**Response `200`:** Single `TransactionDto` object (same fields as list item).

**Error `404`:**

```json
{
  "message": "Transaction not found"
}
```

---

## Transfers

### GET `/transfers`

List accounts available for transfers.

**Response `200`:** Array of `AccountDto` objects.

---

### POST `/transfers`

Submit a money transfer.

**Request:**

```json
{
  "from_account_id": "acc_001",
  "beneficiary_id": "ben_001",
  "amount": 500.00,
  "note": "Rent payment"
}
```

**Response `204`:** No body on success.

**Error `422`:**

```json
{
  "message": "Insufficient funds"
}
```

**Error `409`:**

```json
{
  "message": "Duplicate transfer detected"
}
```

---

### GET `/beneficiaries`

List saved beneficiaries.

**Response `200`:**

```json
[
  {
    "id": "ben_001",
    "name": "Sara Ali",
    "bank_name": "Emirates NBD",
    "account_number": "****7890",
    "avatar_initials": "SA",
    "color": 4283215696
  }
]
```

---

### POST `/beneficiaries`

Add a new beneficiary.

**Request:**

```json
{
  "name": "Sara Ali",
  "bank_name": "Emirates NBD",
  "account_number": "1234567890"
}
```

**Response `201`:**

```json
{
  "id": "ben_002",
  "name": "Sara Ali",
  "bank_name": "Emirates NBD",
  "account_number": "****7890",
  "avatar_initials": "SA",
  "color": 4283215696
}
```

---

## Cards

### GET `/cards`

List all cards.

**Response `200`:**

```json
[
  {
    "id": "card_001",
    "card_number": "**** **** **** 4521",
    "holder_name": "AHMED MOHAMMED",
    "expiry_date": "12/28",
    "cvv": "***",
    "type": "visa",
    "status": "active",
    "balance": 5200.00,
    "currency": "AED",
    "gradient_colors": [4280391411, 4286141768]
  }
]
```

---

### GET `/cards/{id}`

Card details.

**Response `200`:** Single `CardDto` object.

---

### PATCH `/cards/{id}/freeze`

Toggle card freeze status.

**Response `200`:**

```json
{
  "id": "card_001",
  "card_number": "**** **** **** 4521",
  "holder_name": "AHMED MOHAMMED",
  "expiry_date": "12/28",
  "cvv": "***",
  "type": "visa",
  "status": "frozen",
  "balance": 5200.00,
  "currency": "AED",
  "gradient_colors": [4280391411, 4286141768]
}
```

---

## Payments

### GET `/payments/qr`

QR payment receive data.

**Response `200`:**

```json
{
  "user": { "id": "usr_001", "name": "Ahmed", "email": "user@example.com" },
  "account_name": "Primary Checking",
  "account_number": "****4521",
  "iban": "AE070331234567890123456",
  "qr_payload": "bankx://pay?iban=AE07...&name=Ahmed"
}
```

---

### POST `/payments/bills`

Pay a bill.

**Request:**

```json
{
  "amount": 250.00,
  "bill_type": "electricity"
}
```

**Response `204`:** No body.

**Error `422`:**

```json
{
  "message": "Invalid bill type or amount"
}
```

---

## Notifications

### GET `/notifications`

List notifications.

**Response `200`:**

```json
[
  {
    "id": "notif_001",
    "title": "Transfer Complete",
    "body": "Your transfer of AED 500.00 was successful.",
    "time": "2 hours ago",
    "is_read": false,
    "icon": "swap_horiz",
    "color": 4280391411
  }
]
```

---

### PATCH `/notifications/{index}/read`

Mark notification as read by list index.

**Response `204`:** No body.

---

## Profile

### GET `/profile`

User profile with metadata.

**Response `200`:**

```json
{
  "user": { "id": "usr_001", "name": "Ahmed Mohammed", "email": "user@example.com" },
  "card_count": 2,
  "phone": "+971501234567",
  "avatar_url": "https://cdn.bankx.com/avatars/usr_001.jpg",
  "member_since": "2024-03-15"
}
```

---

## Settings

### GET `/settings`

User preferences.

**Response `200`:**

```json
{
  "theme_mode": "system",
  "locale": "en"
}
```

---

### PUT `/settings`

Update preferences.

**Request:**

```json
{
  "theme_mode": "dark",
  "locale": "ar"
}
```

**Response `204`:** No body.

---

## Client Implementation

All endpoints are implemented in:

- **Routes:** `lib/core/constants/api_endpoints.dart`
- **Client:** `lib/shared/data/api/banking_api_service.dart`
- **DTOs:** `lib/shared/data/dto/banking_dtos.dart`
- **Error mapping:** `lib/core/network/api_error_mapper.dart`

Token refresh uses a separate `AuthRefreshClient` to avoid interceptor recursion.
