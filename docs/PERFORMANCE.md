# BankX Performance Guide

Enterprise performance optimizations for the BankX digital banking app. All changes preserve existing UI layout and business rules unless noted.

## Quick profiling with Flutter DevTools

```bash
flutter run --profile
# Open DevTools → Performance, Memory, Network tabs
```

| DevTools tab | What to watch | Likely bottlenecks |
|--------------|---------------|-------------------|
| **Performance** | Frame chart, shader compilation | `SpendingChart` (fl_chart), `BankXLogo` animations, first-route build |
| **CPU Profiler** | Hot methods | `GoogleFonts.inter`, Dio JSON decode, Hive `jsonDecode` |
| **Memory** | Retained objects | Unclosed blocs, FCM stream listeners, large cached lists |
| **Network** | Request waterfall | Dashboard + cards + profile fired together (now deferred per tab) |

---

## Startup optimizations

| Change | File | Why |
|--------|------|-----|
| Deferred settings load, offline sync, session init | `startup_scheduler.dart`, `injection.dart` | Avoids blocking first frame with non-critical I/O |
| Post-frame push notification init | `app.dart` | FCM setup runs after UI is visible |
| Lazy tab data loading | `home_page.dart`, `my_cards_screen.dart`, `profile_page.dart` | Dashboard/cards/profile fetch only when tab is opened |
| Debug-only HTTP logging | `api_client.dart` | `PrettyDioLogger` skipped in release → less CPU and I/O |

---

## Widget rebuild optimizations

| Change | File | Why |
|--------|------|-----|
| `BlocSelector` for app theme/locale | `app.dart`, `app_appearance.dart` | Settings changes no longer rebuild the entire widget tree |
| `buildWhen` predicates | `bloc_build_when.dart`, feature pages | Home ignores analytics state; cards ignore freeze state, etc. |
| `RepaintBoundary` on charts | `spending_chart.dart` | Isolates fl_chart repaints from scrolling content |
| `FilterQuality.medium` on logo | `bankx_logo.dart` | Reduces GPU work for static asset |

### `buildWhen` coverage

- Dashboard home / analytics (split)
- Cards list, profile, transactions list, notifications list
- Transfer load, settings, accounts, QR/bill payment states

---

## Scrolling optimizations

| Screen | Pattern | Why |
|--------|---------|-----|
| Home accounts | `ListView.separated` horizontal | Lazy build per account card |
| Home transactions | `SliverChildBuilderDelegate` | Lazy recent transactions |
| Transfer accounts/beneficiaries | `ListView.separated` + `shrinkWrap` | Lazy rows instead of eager `.map()` spread |
| Notifications, beneficiaries | `ListView.separated` | Standard lazy list |

---

## Network optimizations

| Change | File | Why |
|--------|------|-----|
| `CachingNetworkInfo` (3s TTL) | `network_info.dart` | Avoids duplicate connectivity + internet checks per repository call |
| `RetryInterceptor` for GET | `retry_interceptor.dart` | Retries transient timeouts without user action |
| Debug-only logger | `api_client.dart` | Release builds avoid stringifying request/response bodies |
| Hive TTL + purge | `cache_storage_service.dart` | Expired envelopes removed on init → smaller box, faster reads |

Existing patterns retained: `NetworkBoundResource`, remote data source cache writes, offline transfer queue.

---

## Memory & lifecycle

| Change | File | Why |
|--------|------|-----|
| Close root feature blocs | `app.dart` | Prevents bloc leaks on hot restart / tests |
| `StartupScheduler.shutdown()` | `app.dart`, `startup_scheduler.dart` | Disposes offline sync, session manager, FCM listeners |
| FCM subscription cancel | `push_notification_service.dart` | Prevents stream leaks |
| Session activity debounce (30s) | `session_manager.dart` | Fewer secure-storage writes |
| Remove `onPointerMove` tracking | `session_activity_detector.dart` | Stops write storm during scroll |

---

## Image optimizations

| Component | File | Why |
|-----------|------|-----|
| `CachedAppImage` | `cached_app_image.dart` | Disk + memory cache, placeholder, error widget, `memCacheWidth/Height`, prefetch API |

No remote images in UI yet; widget is ready for avatars/banners without layout changes.

---

## Offline / Hive

- TTL per feature via `CachePolicy`
- `purgeExpired()` on cache init removes stale keys
- Transfer queue unchanged; sync deferred to post-frame startup

---

## App size

| Action | Impact |
|--------|--------|
| Removed unused `flutter_svg` | Smaller dependency tree |
| Release builds skip Dio logger | Smaller runtime overhead (not APK size) |
| `cached_network_image` added | Small increase; required for future remote assets |

**Further size wins (manual):**
- Bundle Inter via `google_fonts` asset mode to avoid runtime font fetch
- Run `flutter build apk --analyze-size` / `app-size-analysis`

---

## Notifications batching

`AllNotificationsMarkedRead` emits **one** loading + **one** success state instead of N rebuilds from the UI loop.

---

## Animation

- `RepaintBoundary` around chart repaints
- Logo uses `FilterQuality.medium`
- Implicit / existing controllers unchanged (no UI change)

---

## Measuring impact

```bash
# Profile mode (near-production performance)
flutter run --profile

# Release size analysis
flutter build apk --analyze-size
flutter build appbundle --analyze-size

# Timeline startup
flutter run --trace-startup
```

### Expected improvements

1. **Faster first frame** — deferred sync/settings/session/push
2. **Smoother scroll** — fewer bloc rebuilds + session write throttling
3. **Lower release CPU** — no Dio body logging
4. **Better resilience** — GET retry on transient failures
5. **Smaller Hive footprint** — expired cache purge on launch

---

## Adding new features without regressions

1. Use `BlocBuildWhen` or add a new predicate in `bloc_build_when.dart`
2. Load data in tab/screen `didChangeDependencies`, not in `app.dart`
3. Use `ListView.builder` / `SliverList` for unbounded lists
4. Use `CachedAppImage` for any `http` image URL
5. Write through Hive with `CachePolicy.forKey(key)` TTL
