# Remote Setup — BankX

إعداد GitHub Remote، Firebase CI، والنشر من السحابة.

## 1. GitHub Repository

حسابك: **`ahmedehab96-c`**

```bash
chmod +x scripts/setup_github_remote.sh
./scripts/setup_github_remote.sh public   # أو private
```

أو يدوياً:

```bash
gh repo create bankx --public --source=. --remote=origin
git push -u origin main
```

الرابط: https://github.com/ahmedehab96-c/bankx

---

## 2. Firebase — محلي (تم)

| ملف | المسار |
|-----|--------|
| Android | `android/app/google-services.json` |
| iOS | `ios/Runner/GoogleService-Info.plist` |
| Dart | `lib/core/firebase/firebase_options.dart` |

**مشروع Firebase:** `bankx-app-c0958`

---

## 3. GitHub Secrets (مطلوب للـ CI/CD)

**الحالة:** تم إعداد الأسرار الأساسية عبر `gh secret set` (ما عدا `FIREBASE_TOKEN`).

شغّل مرة واحدة:

```bash
chmod +x scripts/setup_github_secrets.sh
./scripts/setup_github_secrets.sh
```

أو يدوياً — طباعة base64:

```bash
./scripts/encode_firebase_secrets.sh
```

| Secret | الحالة |
|--------|--------|
| `GOOGLE_SERVICES_JSON_BASE64` | ✅ مضاف |
| `GOOGLE_SERVICE_INFO_PLIST_BASE64` | ✅ مضاف |
| `FIREBASE_APP_ID_ANDROID` | ✅ مضاف |
| `FIREBASE_APP_ID_IOS` | ✅ مضاف |
| `FIREBASE_TOKEN` | ⚠️ يدوي — انظر §4 |

### اختياري (توقيع + توزيع)

| Secret | الوصف |
|--------|--------|
| `ANDROID_KEYSTORE_BASE64` | keystore للإصدار |
| `ANDROID_KEYSTORE_PASSWORD` | |
| `ANDROID_KEY_ALIAS` | |
| `ANDROID_KEY_PASSWORD` | |
| `IOS_P12_BASE64` | شهادة iOS |
| `IOS_P12_PASSWORD` | |
| `CODECOV_TOKEN` | تغطية الكود |

### Variables

| Variable | القيمة |
|----------|--------|
| `FIREBASE_TESTER_GROUPS` | `qa-testers` |

---

## 4. Firebase CLI token

```bash
npm install -g firebase-tools
firebase login:ci
# انسخ التوكن → FIREBASE_TOKEN في GitHub
```

---

## 5. تشغيل Workflows

| Workflow | متى |
|----------|-----|
| **Pull Request** | تلقائي عند PR |
| **Release** | push إلى `main` |
| **Firebase App Distribution** | يدوي من Actions |

```bash
# توزيع تجريبي يدوي
gh workflow run firebase-distribution.yml -f environment=staging -f platform=android
```

---

## 6. التشغيل المحلي

```bash
# Development (بدون Firebase)
flutter run $(./scripts/load_env.sh development)

# Staging (مع Firebase)
flutter run $(./scripts/load_env.sh staging)
```

من Cursor: اختر **BankX (staging + Firebase)** من Run and Debug.

---

## 7. قائمة تحقق

- [x] ملفات Firebase محلية
- [x] `firebase_options.dart` محدّث
- [x] Workflows تدعم `load_firebase_config.sh`
- [ ] رفع المشروع إلى GitHub (`setup_github_remote.sh`)
- [ ] إضافة GitHub Secrets
- [ ] تفعيل Crashlytics في Firebase Console
- [ ] إنشاء مجموعة `qa-testers` في App Distribution
- [ ] لقطات شاشة في `docs/assets/screenshots/`

---

## مراجع

- [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
- [CICD.md](CICD.md)
- [DEPLOYMENT.md](DEPLOYMENT.md)
