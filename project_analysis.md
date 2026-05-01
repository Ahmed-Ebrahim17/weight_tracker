# Kinetic Sanctuary — Project Analysis

> **Date:** April 30, 2026  
> **Project:** `weight_tracker` (Flutter)  
> **Guide Reference:** "How Kinetic Sanctuary Works: A Guide for Developers"

---

## 1. What Is the Database Doing & Why?

### The Short Answer
The database is the **offline brain** of your app. It stores every weight entry the user logs directly on the phone using **SQLite** (via the **Drift** library). No internet needed — the moment the user taps "Save," the data is written to a file on the device.

### The Architecture (4 Layers)

```
┌─────────────────────────────────────┐
│          UI (Widgets/Screens)       │  ← What the user sees
├─────────────────────────────────────┤
│       WeightEntryService            │  ← Clean API + business logic (trend calculations)
├─────────────────────────────────────┤
│       AppDatabase (Drift)           │  ← Type-safe queries, CRUD operations
├─────────────────────────────────────┤
│       SQLite File on Device         │  ← Actual data storage (weight_tracker_db)
└─────────────────────────────────────┘
```

### What Each Database File Does

| File | Purpose |
|------|---------|
| [weight_entry_table.dart](file:///g:/Programming/Projects/weight_tracker/lib/core/database/tables/weight_entry_table.dart) | **Defines the table schema** — columns for `id`, `weight`, `date`, `time`, `notes`, `createdAt`, `updatedAt`. This is like the blueprint of a spreadsheet. |
| [database.dart](file:///g:/Programming/Projects/weight_tracker/lib/core/database/database.dart) | **The main database class** — contains all CRUD methods: `createWeightEntry`, `getAllWeightEntries`, `getLatestWeightEntry`, `getWeightEntriesLastNDays`, `updateWeightEntry`, `deleteWeightEntry`, `deleteAllWeightEntries`, `getWeightEntriesCount`. |
| `database.g.dart` | **Auto-generated code** — Drift reads your table definitions and generates all the SQL and type-safe Dart code. You never edit this file. |
| [weight_entry_service.dart](file:///g:/Programming/Projects/weight_tracker/lib/core/database/services/weight_entry_service.dart) | **Service layer** — wraps the database with a cleaner API and adds business logic like `getSevenDayTrend()` (calculates weight change over 7 days). |

### Why This Matters

1. **Offline-First:** Data saves instantly to the phone — no WiFi required
2. **Type-Safe:** Drift catches errors at compile time (e.g., you can't accidentally query a column that doesn't exist)
3. **Separation of Concerns:** UI → Service → Database → SQLite. If you change the database, you only update the service layer, not every screen
4. **CRUD Foundation:** Create, Read, Update, Delete — the four core operations every data app needs

### How Data Flows (Example: User adds weight)

```
User taps "Add Weight" → Dialog appears → User enters 73.4 kg
    ↓
WeightEntryService.addWeightEntry(weight: 73.4, date: now, time: now)
    ↓
AppDatabase.createWeightEntry() → generates SQL:
    INSERT INTO weight_entries (weight, date, time, ...) VALUES (73.4, ...)
    ↓
SQLite writes to file on device → returns ID
    ↓
Dashboard refreshes → shows "Latest Weight: 73.4 kg"
```

---

## 2. What's Already Done ✅

### Project Foundation
| Step | Status | Details |
|------|--------|---------|
| Flutter project created | ✅ | `weight_tracker` with clean structure |
| Manrope custom font | ✅ | 6 weights registered (300–800) in [pubspec.yaml](file:///g:/Programming/Projects/weight_tracker/pubspec.yaml) |
| Color system | ✅ | Full palette (Primary, Secondary, Tertiary, Neutral) in [colors.dart](file:///g:/Programming/Projects/weight_tracker/lib/core/theming/colors.dart) |
| Text styles | ✅ | Defined in `styles.dart` with font weight helpers |
| App strings | ✅ | Centralized in [app_strings.dart](file:///g:/Programming/Projects/weight_tracker/lib/core/constants/app_strings.dart) |
| Screen utilities | ✅ | `flutter_screenutil` for responsive sizing |
| Navigation extensions | ✅ | `pushNamed`, `pushReplacementNamed`, `pushNamedAndRemoveUntil` in [extensions.dart](file:///g:/Programming/Projects/weight_tracker/lib/core/helper/extensions.dart) |

### Database Layer (The "Engine")
| Step | Status | Details |
|------|--------|---------|
| Drift + SQLite dependencies | ✅ | `drift`, `drift_flutter`, `sqlite3_flutter_libs` |
| Weight entry table schema | ✅ | 7 columns: `id`, `weight`, `date`, `time`, `notes`, `createdAt`, `updatedAt` |
| Database class with CRUD | ✅ | All operations: Create, Read (all/latest/last N days), Update, Delete (single/all), Count |
| Code generation (`database.g.dart`) | ✅ | Generated successfully |
| Service layer | ✅ | `WeightEntryService` with clean API + `getSevenDayTrend()` |
| Database registered in DI | ✅ | `AppDatabase` singleton registered in [dependency_injection.dart](file:///g:/Programming/Projects/weight_tracker/lib/core/di/dependency_injection.dart) |
| Database Setup Guide | ✅ | Comprehensive [DATABASE_SETUP_GUIDE.md](file:///g:/Programming/Projects/weight_tracker/DATABASE_SETUP_GUIDE.md) |

### Authentication (Supabase + Google)
| Step | Status | Details |
|------|--------|---------|
| Supabase initialization | ✅ | URL + Anon Key from `.env` |
| Email login/register | ✅ | Full flow via `AuthRemoteDataSource` |
| Google Sign-In | ✅ | OAuth with ID token → Supabase |
| Local session caching | ✅ | `AuthLocalDataSource` using `SharedPreferences` |
| Auth repository (Clean Architecture) | ✅ | Interface + Implementation with error mapping |
| 5 Use Cases | ✅ | `EmailLogin`, `EmailRegister`, `GoogleLogin`, `GetCurrentUser`, `Logout` |
| AuthCubit (state management) | ✅ | Handles all auth actions + emits typed states |
| Auth states | ✅ | `AuthInitial`, `AuthLoading`, `AuthSuccess`, `AuthFailure` |
| Custom auth exceptions | ✅ | 8 exception types (InvalidEmail, WeakPassword, etc.) |
| Failure mapping | ✅ | Sealed `Failure` class with `Network`, `Validation`, `Auth`, `Server`, `Unknown` |

### UI Screens
| Step | Status | Details |
|------|--------|---------|
| Splash screen | ✅ | With auth state listener, navigates based on auth |
| Login screen | ✅ | Full body with email/password fields, Google/Apple buttons, "Don't have account" link |
| Register screen | ✅ | Full body with name/email/password, terms & conditions |
| Login/Register BLoC listeners | ✅ | Handle success/failure states with snackbars |
| Form validation widgets | ✅ | Email validator, password validator |

### Core Widgets
| Step | Status | Details |
|------|--------|---------|
| `AppTextButton` | ✅ | Reusable button with shadow |
| `AppTextField` | ✅ | Reusable text field |
| `LoadingIndicator` | ✅ | Loading widget |
| `showSnackBar` | ✅ | Snackbar utility |

### Routing
| Step | Status | Details |
|------|--------|---------|
| Route constants | ✅ | 12 routes defined in [routes.dart](file:///g:/Programming/Projects/weight_tracker/lib/core/routing/routes.dart) |
| App Router | ⚠️ Partial | Only `splash`, `login`, `register` have actual route handlers. The rest (home, settings, profile, etc.) fall to the default "No route defined" screen |

### Dashboard (Home Screen)
| Step | Status | Details |
|------|--------|---------|
| Basic dashboard | ✅ | In [home_screen.dart](file:///g:/Programming/Projects/weight_tracker/lib/features/home/presentation/screens/home_screen.dart) (under `features/home/`) |
| Latest weight display | ✅ | Card showing current weight from database |
| 7-day trend | ✅ | Card showing weight change over 7 days |
| Total entries count | ✅ | Card showing number of logs |
| Add weight dialog | ✅ | Form with weight (kg) + optional notes |
| Pull-to-refresh | ✅ | `RefreshIndicator` on dashboard |
| Logout button | ✅ | AppBar action that calls `AuthCubit.logout()` |

### Dependency Injection
| Step | Status | Details |
|------|--------|---------|
| GetIt setup | ✅ | All auth dependencies registered |
| AppDatabase singleton | ✅ | Registered |
| WeightEntryService | ❌ | **NOT registered in DI** — it's created manually in the home screen |

---

## 3. What's Missing ❌

### A. Dashboard (The "Hub") — Partially Done

| Missing Item | Priority | Description |
|-------------|----------|-------------|
| 7-Day Line Chart | 🔴 High | The guide says: *"The 7-day chart pulls the last 7 data points to draw the line graph."* Currently only a text card showing the trend number — no actual **graph/chart visualization**. Need a charting library like `fl_chart`. |
| Polished UI Design | 🟡 Medium | Current dashboard uses basic `Card` + `ListTile`. Should match the premium design aesthetic of the auth screens (colors, gradients, icons). |
| Home route not wired | 🔴 High | The `Routes.homeScreen` (`/home`) is defined but **not handled** in `AppRouter.generateRoute()`. The working dashboard is in `features/home/` but isn't reachable via the router. |
| WeightEntryService not in DI | 🟡 Medium | Service is manually instantiated in home screen instead of being injected via GetIt. |

### B. Journey & History (The "Log") — Not Started

| Missing Item | Priority | Description |
|-------------|----------|-------------|
| History screen | 🔴 High | List all weight entries in **reverse-chronological order**. Database method `getAllWeightEntries()` exists but no UI screen to display it. |
| Edit/Delete entries | 🔴 High | Database has `updateWeightEntry()` and `deleteWeightEntry()` but no UI to trigger them. Users can't manage their existing logs. |
| Goal weight setting | 🔴 High | *"It subtracts Current Weight from Goal Weight set in Settings"* — no goal weight field exists anywhere in the codebase. |
| Goal progress display | 🔴 High | Show "X kg left to goal" — depends on goal weight being stored. |
| Weight tracking Cubit/BLoC | 🔴 High | The `features/weight_tracking/presentation/cubits/` directory is **empty**. No state management for weight operations. |
| Weight tracking feature layers | 🔴 High | All directories under `features/weight_tracking/` (`data/datasources`, `data/models`, `data/repositories`, `domain/entities`, `domain/repositories`, `domain/usescases`) are **completely empty**. |

### C. Insights (The "Brain") — Not Started

| Missing Item | Priority | Description |
|-------------|----------|-------------|
| Insights screen | 🔴 High | Entirely missing. No screen for long-term health metrics. |
| BMI calculation | 🔴 High | *"Calculated using Weight / Height²"* — no height field stored anywhere (not in database, not in SharedPreferences). |
| User preferences/profile | 🔴 High | Need to store: height, goal weight, preferred unit (kg/lbs). None of this exists. |
| Milestones system | 🟡 Medium | *"Triggered when certain conditions are met"* — e.g., "Goal Reached" badge. No milestone logic or UI. |
| Metabolic rate calculation | 🟡 Medium | Mentioned in the guide. Requires additional user data (age, gender, activity level). |

### D. Settings & Data (The "Vault") — Not Started

| Missing Item | Priority | Description |
|-------------|----------|-------------|
| Settings screen | 🔴 High | Route exists (`/settings`) but no screen implementation. |
| CSV Export | 🔴 High | *"Iterates through all local database rows and writes to a CSV file."* No export functionality exists. |
| CSV Import | 🔴 High | Mentioned in guide. Must validate data integrity on import. |
| Reminder notifications | 🟡 Medium | *"Uses the device's local notification API."* No notification package or logic. Need `flutter_local_notifications`. |
| User preferences storage | 🔴 High | Goal weight, height, units — none stored. |
| Profile screen | 🟡 Medium | Route defined, no implementation. |

### E. Navigation & UX — Incomplete

| Missing Item | Priority | Description |
|-------------|----------|-------------|
| Bottom navigation bar | 🔴 High | The guide describes 4 main sections (Dashboard, Journey, Insights, Settings). No tab bar or bottom nav exists. |
| Post-login navigation | 🔴 High | After successful login, the app should navigate to the dashboard. This flow needs to be connected in the router. |
| Home route in AppRouter | 🔴 High | `Routes.homeScreen` is defined but the `AppRouter` has no `case` for it. |
| Duplicate HomeScreen | 🟡 Medium | There are **two** `HomeScreen` files: one at `features/home/presentation/screens/` (functional, 321 lines) and one at `features/weight_tracking/presentation/screens/` (placeholder, just a `Placeholder()` widget). This is confusing. |

### F. Data Architecture Gaps

| Missing Item | Priority | Description |
|-------------|----------|-------------|
| User preferences table/storage | 🔴 High | Height, goal weight, units, reminder time — nothing stored. |
| Data validation on import | 🟡 Medium | Guide says: *"CSV Import must validate data to ensure the user isn't importing broken or empty records."* |
| Reactive streams (watchers) | 🟡 Medium | Drift supports `watch()` streams for real-time UI updates. Currently using `FutureBuilder` + manual refresh. |
| Connectivity handling | 🟡 Medium | `connectivity_plus` package is installed but not used anywhere. |
| Firebase Crashlytics | 🟡 Medium | Package is in `pubspec.yaml` but not initialized in `main.dart`. |

### G. Testing — Not Started

| Missing Item | Priority | Description |
|-------------|----------|-------------|
| Unit tests | 🟡 Medium | No tests written for database, service, or cubits. |
| Widget tests | 🟡 Medium | No widget tests for any screen. |
| Integration tests | 🟢 Low | Can be added later. |

---

## 4. Summary: Progress Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                    KINETIC SANCTUARY PROGRESS                   │
├─────────────────────────┬───────────────────────────────────────┤
│ Foundation & Setup      │ ██████████████████████████████ 100%   │
│ Authentication          │ ██████████████████████████████  95%   │
│ Database Layer          │ ██████████████████████████████  95%   │
│ Dashboard (Hub)         │ ███████████████░░░░░░░░░░░░░░░  50%   │
│ Journey & History (Log) │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%   │
│ Insights (Brain)        │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%   │
│ Settings & Data (Vault) │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%   │
│ Navigation/UX           │ █████░░░░░░░░░░░░░░░░░░░░░░░░░  15%   │
│ Testing                 │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%   │
├─────────────────────────┼───────────────────────────────────────┤
│ OVERALL                 │ ██████████░░░░░░░░░░░░░░░░░░░ ~35%   │
└─────────────────────────┴───────────────────────────────────────┘
```

---

## 5. Recommended Next Steps (In Order)

> [!TIP]
> Follow this order to build incrementally — each step unlocks the next.

1. **Fix routing** — Wire `Routes.homeScreen` in `AppRouter` and connect post-login navigation
2. **Clean up duplicate HomeScreen** — Decide which `HomeScreen` to keep; consolidate into `features/weight_tracking/`
3. **Register `WeightEntryService` in DI** — Move from manual creation to GetIt singleton
4. **Build the Weight Tracking Cubit** — State management for weight CRUD operations
5. **Add a charting library** (`fl_chart`) — Implement the 7-day line chart on the dashboard
6. **Build History screen** — List all entries with edit/delete actions
7. **Add User Preferences** — Store height, goal weight, units in SharedPreferences or a new DB table
8. **Build Insights screen** — BMI calculator, milestones
9. **Build Settings screen** — CSV export/import, reminders, profile
10. **Add bottom navigation** — Connect all 4 main screens

---

## 6. File Tree Reference

```
lib/
├── main.dart                          ← App entry point (Supabase init, DI setup)
├── weight_tracker_app.dart            ← MaterialApp with ScreenUtil, Manrope font
├── core/
│   ├── constants/
│   │   └── app_strings.dart           ← All UI strings
│   ├── database/
│   │   ├── database.dart              ← AppDatabase with all CRUD methods
│   │   ├── database.g.dart            ← Auto-generated (DO NOT EDIT)
│   │   ├── tables/
│   │   │   └── weight_entry_table.dart ← Table schema + WeightEntry class
│   │   └── services/
│   │       └── weight_entry_service.dart ← Business logic layer
│   ├── di/
│   │   └── dependency_injection.dart  ← GetIt registrations
│   ├── error/
│   │   ├── api_result.dart            ← Either type alias
│   │   └── failure.dart               ← Sealed Failure classes
│   ├── exceptions/
│   │   └── auth_exceptions.dart       ← 8 auth exception types
│   ├── helper/
│   │   ├── assets.dart                ← Asset path constants
│   │   ├── extensions.dart            ← Navigation extensions
│   │   └── spacing.dart               ← Spacing utilities
│   ├── routing/
│   │   ├── app_router.dart            ← Route generator (⚠️ incomplete)
│   │   └── routes.dart                ← Route name constants
│   ├── theming/
│   │   ├── colors.dart                ← Full color palette
│   │   ├── font_weight_helper.dart    ← Font weight constants
│   │   └── styles.dart                ← Text style definitions
│   ├── validators/
│   │   ├── email_validator.dart
│   │   └── password_validator.dart
│   └── widgets/
│       ├── app_text_button.dart
│       ├── app_text_field.dart
│       ├── loading_indicator.dart
│       └── show_snackbar.dart
├── features/
│   ├── auth/                          ← ✅ COMPLETE (Clean Architecture)
│   │   ├── data/
│   │   │   ├── datasources/           ← Remote (Supabase) + Local (SharedPreferences)
│   │   │   ├── models/                ← AuthResponseModel, AuthUserModel
│   │   │   └── repositories/          ← AuthRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/              ← AuthUser
│   │   │   ├── repositories/          ← AuthRepository interface
│   │   │   └── usecases/              ← 5 use cases
│   │   └── presentation/
│   │       ├── cubits/                ← AuthCubit + AuthState
│   │       ├── screens/               ← LoginScreen, RegisterScreen
│   │       └── widgets/               ← 16 auth UI widgets
│   ├── home/                          ← ⚠️ Working dashboard but not routed
│   │   └── presentation/screens/
│   │       └── home_screen.dart       ← 321 lines, functional
│   ├── splash/                        ← ✅ COMPLETE
│   │   └── presentation/screens/
│   │       └── splash_screen.dart
│   └── weight_tracking/               ← ❌ MOSTLY EMPTY SKELETON
│       ├── data/
│       │   ├── datasources/           ← EMPTY
│       │   ├── models/                ← EMPTY
│       │   └── repositories/          ← EMPTY
│       ├── domain/
│       │   ├── entities/              ← EMPTY
│       │   ├── repositories/          ← EMPTY
│       │   └── usescases/             ← EMPTY (also typo: "usescases")
│       └── presentation/
│           ├── cubits/                ← EMPTY
│           ├── screens/
│           │   └── home_screen.dart   ← Placeholder() only (10 lines)
│           └── widgets/               ← EMPTY
```

> [!WARNING]
> There's a **typo** in the directory name: `features/weight_tracking/domain/usescases/` should be `usecases` (one 's'). Consider renaming to keep consistency with the auth feature which uses `usecases`.
