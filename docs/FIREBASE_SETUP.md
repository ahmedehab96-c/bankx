# Firebase Setup — BankX

ربط مشروع BankX بـ Firebase (Analytics, Crashlytics, Cloud Messaging, App Distribution).

## المتطلبات

- حساب [Firebase Console](https://console.firebase.google.com/)
- Flutter SDK + `dart pub global activate flutterfire_cli`
- Bundle ID: `com.bankx.bankx` (Android + iOS)

## الخطوة 1 — إنشاء مشروع Firebase

1. Firebase Console → **Add project** (مثال: `bankx-app`)
2. فعّل **Google Analytics** (اختياري لكن موصى به)
3. **Add app** → Android:
   - Package name: `com.bankx.bankx`
   - حمّل `google-services.json` → ضعه في `android/app/google-services.json`
4. **Add app** → iOS:
   - Bundle ID: `com.bankx.bankx`
   - حمّل `GoogleService-Info.plist` → ضعه في `ios/Runner/GoogleService-Info.plist`

> الملفات الحقيقية **مُستثناة من Git** (`.gitignore`). استخدم `.example` كمرجع.

## الخطوة 2 — FlutterFire CLI (موصى به)

```bash
chmod +x scripts/setup_firebase.sh
./scripts/setup_firebase.sh
```

أو يدوياً:

```bash
dart pub global activate flutterfire_cli
export PATH="$PATH:$HOME/.pub-cache/bin"
flutterfire configure \
  --android-package-name=com.bankx.bankx \
  --ios-bundle-id=com.bankx.bankx \
  --out=lib/core/firebase/firebase_options.dart
```

هذا يحدّث `lib/core/firebase/firebase_options.dart` بقيم المشروع.

## الخطوة 3 — تفعيل Firebase في التطبيق

عدّل `config/env/staging.json` و `production.json`:

```json
{
  "FIREBASE_CONFIGURED": "true",
  "BANKX_ENABLE_ANALYTICS": "true",
  "BANKX_ENABLE_CRASHLYTICS": "true"
}
```

شغّل:

```bash
flutter run $(./scripts/load_env.sh staging)
```

عند التشغيل، `main.dart` يستدعي `FirebaseBootstrap.initialize()` — يعمل فقط عندما `FIREBASE_CONFIGURED=true`.

## الخطوة 4 — خدمات Firebase

| الخدمة | الحالة في BankX | التفعيل في Console |
|--------|-----------------|-------------------|
| Analytics | `AnalyticsService` | تلقائي مع Core |
| Crashlytics | `CrashlyticsService` | Firebase → Crashlytics → Enable |
| Cloud Messaging | `PushNotificationService` | Cloud Messaging + APNs key (iOS) |
| App Distribution | CI workflow | App Distribution → Get started |

### iOS — Push Notifications

1. Apple Developer → Keys → APNs Auth Key
2. Firebase → Project Settings → Cloud Messaging → رفع APNs key
3. Xcode → Runner → Signing & Capabilities → **Push Notifications**

### Android — Google Services plugin

يُطبَّق تلقائياً عند وجود `android/app/google-services.json` (انظر `android/app/build.gradle.kts`).

## الخطوة 5 — GitHub Secrets (CI)

| Secret | الوصف |
|--------|--------|
| `FIREBASE_TOKEN` | `firebase login:ci` |
| `FIREBASE_APP_ID_ANDROID` | من Firebase Console → App settings |
| `FIREBASE_APP_ID_IOS` | نفس المكان لتطبيق iOS |

Workflow: `.github/workflows/firebase-distribution.yml`

```bash
firebase login:ci
# انسخ التوكن إلى GitHub Secret FIREBASE_TOKEN
```

## التحقق

```bash
# بدون Firebase (افتراضي development)
flutter run $(./scripts/load_env.sh development)

# مع Firebase
flutter run $(./scripts/load_env.sh staging)
```

في السجلات يجب ألا يظهر `Firebase init skipped` عند التفعيل الصحيح.

## استكشاف الأخطاء

| المشكلة | الحل |
|---------|------|
| `Firebase init skipped` | `FIREBASE_CONFIGURED=false` أو ملفات المنصة ناقصة |
| `REPLACE_ME` في firebase_options | شغّل `flutterfire configure` |
| Android build fails | تأكد من `google-services.json` في `android/app/` |
| iOS push لا يعمل | APNs key + Push capability في Xcode |

## مراجع

- [DEPLOYMENT.md](DEPLOYMENT.md)
- [CICD.md](CICD.md)
- [FlutterFire docs](https://firebase.flutter.dev/docs/overview)
