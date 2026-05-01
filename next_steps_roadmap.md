# Kinetic Sanctuary — Next Steps Roadmap

> **Current Status:** Foundation ✅ → Auth ✅ → Database ✅ → **You are here**
> 
> Old `features/home/` deleted. Fresh start from `features/weight_tracking/`.

---

## Phase 1: Fix Routing & Navigation (Do First)

### Step 1.1 — Wire the Home Route in AppRouter
**File:** `lib/core/routing/app_router.dart`
- Add a `case Routes.homeScreen:` that navigates to the new `HomeScreen` from `features/weight_tracking/`
- Provide both `AuthCubit` and a new `WeightTrackingCubit` via `BlocProvider`

### Step 1.2 — Connect Post-Login Navigation  
**File:** Auth BLoC listeners / Splash screen
- After successful login → navigate to `Routes.homeScreen`
- After splash detects authenticated user → navigate to `Routes.homeScreen`
- Currently the splash screen doesn't navigate anywhere on `AuthSuccess`

---

## Phase 2: Weight Tracking State Management

### Step 2.1 — Create Weight Tracking States
**File:** `lib/features/weight_tracking/presentation/cubits/weight_tracking_state.dart`
- Define states: `WeightTrackingInitial`, `WeightTrackingLoading`, `WeightTrackingLoaded`, `WeightTrackingError`
- The `Loaded` state should hold: `latestWeight`, `sevenDayTrend`, `totalEntries`, `recentEntries` (list)

### Step 2.2 — Create Weight Tracking Cubit
**File:** `lib/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart`
- Methods:
  - `loadDashboardData()` — fetch latest weight, trend, count, last 7 entries
  - `addWeightEntry(weight, notes)` — save to DB then reload
  - `deleteWeightEntry(id)` — delete then reload
  - `updateWeightEntry(id, weight, notes)` — update then reload
- Uses `WeightEntryService` from DI (already registered ✅)

### Step 2.3 — Register Cubit in DI
**File:** `lib/core/di/dependency_injection.dart`
- Register `WeightTrackingCubit` as a factory (not singleton — it ties to screen lifecycle)

---

## Phase 3: Build the Dashboard (HomeScreen)

### Step 3.1 — Build the Dashboard Layout
**File:** `lib/features/weight_tracking/presentation/screens/home_screen.dart`
- Use `BlocBuilder<WeightTrackingCubit, WeightTrackingState>` instead of `FutureBuilder`
- Layout:
  - **AppBar** with title "Dashboard" + logout button
  - **Current Weight Card** — large, prominent card showing latest weight
  - **7-Day Trend Card** — shows +/- kg with an up/down arrow icon
  - **Total Entries Card** — count badge
  - **7-Day Chart** — line graph (needs `fl_chart` package)
  - **FAB** — "Add Weight" button

### Step 3.2 — Add `fl_chart` Package
- Run: `flutter pub add fl_chart`
- Build a `WeightChart` widget showing last 7 data points as a line graph

### Step 3.3 — Create Dashboard Widgets (Break it Up)
**Directory:** `lib/features/weight_tracking/presentation/widgets/`
- `weight_summary_card.dart` — current weight display
- `trend_card.dart` — 7-day trend with colored indicator
- `weight_chart.dart` — 7-day line chart using `fl_chart`
- `add_weight_dialog.dart` — the dialog/bottom sheet for adding entries
- `dashboard_body.dart` — composes all the above widgets

---

## Phase 4: Build Journey & History Screen

### Step 4.1 — Create History Screen
**File:** `lib/features/weight_tracking/presentation/screens/history_screen.dart`
- Shows ALL weight entries in reverse-chronological order
- Each entry shows: date, time, weight, notes (if any)
- Swipe-to-delete or long-press menu for edit/delete

### Step 4.2 — Create History Widgets
**Directory:** `lib/features/weight_tracking/presentation/widgets/`
- `weight_entry_tile.dart` — single entry row
- `edit_weight_dialog.dart` — dialog to edit an existing entry
- `empty_history_view.dart` — friendly message when no entries exist

### Step 4.3 — Add Goal Weight Feature
- Store goal weight in `SharedPreferences` (or new DB table)
- Show "X kg left to go" calculation on the history screen
- Add a "Set Goal" option (can be a dialog or in Settings later)

---

## Phase 5: Build Bottom Navigation

### Step 5.1 — Create Main Navigation Shell
**File:** `lib/features/weight_tracking/presentation/screens/main_screen.dart`
- `Scaffold` with `BottomNavigationBar` (or `NavigationBar` for Material 3)
- 4 tabs:
  1. **Dashboard** (Home icon)
  2. **History/Journey** (List icon)
  3. **Insights** (Analytics icon)
  4. **Settings** (Gear icon)
- Uses `IndexedStack` or `PageView` to preserve tab state

### Step 5.2 — Update Router
- `Routes.homeScreen` → points to `MainScreen` (the shell with bottom nav)
- Each tab is a nested widget, not a separate route

---

## Phase 6: Build Insights Screen

### Step 6.1 — Add User Preferences
- Store in `SharedPreferences`: height (cm), age, gender, activity level, preferred unit (kg/lbs)
- Create a `UserPreferencesService` to read/write these values
- Show a one-time "Setup Profile" dialog on first launch

### Step 6.2 — Create Insights Screen
**File:** `lib/features/weight_tracking/presentation/screens/insights_screen.dart`
- **BMI Card** — calculated from (weight / height²)  
  - Shows BMI number + category (Underweight/Normal/Overweight/Obese)
  - Needs height from user preferences
- **Milestones Section** — badges/achievements:
  - "First Entry" — logged first weight
  - "Week Streak" — 7 consecutive days
  - "Goal Reached" — current weight ≤ goal weight
  - "5kg Lost" — lost 5kg from starting weight
- **Progress Chart** — longer-term chart (30 days / all time)

### Step 6.3 — Create Insights Widgets
- `bmi_card.dart` — BMI display with color-coded indicator
- `milestone_badge.dart` — single milestone with icon and status
- `progress_chart.dart` — full history chart

---

## Phase 7: Build Settings Screen

### Step 7.1 — Create Settings Screen
**File:** `lib/features/weight_tracking/presentation/screens/settings_screen.dart`
- **Profile Section:** Edit name, height, age, goal weight, preferred unit
- **Data Section:** Export CSV, Import CSV
- **Notifications Section:** Set daily reminder time
- **Account Section:** Logout, delete account
- **About Section:** App version, credits

### Step 7.2 — CSV Export
- Iterate all weight entries → write to CSV file
- Use `path_provider` to get the downloads directory
- Share via `share_plus` package (or save to files)

### Step 7.3 — CSV Import
- Pick a CSV file using `file_picker` package
- Parse and validate each row (check weight > 0, date is valid, etc.)
- Insert valid rows into database
- Show summary: "Imported 45 entries, 3 skipped (invalid)"

### Step 7.4 — Daily Reminder Notifications
- Add `flutter_local_notifications` package
- Let user pick a time (e.g., 8:00 AM)
- Schedule a daily repeating notification: "Time to log your weight! 🏋️"
- Store reminder time in SharedPreferences

---

## Phase 8: Polish & Finishing Touches

### Step 8.1 — Themed UI Overhaul
- Apply your existing color system (`ColorsManager`) consistently across all screens
- Add gradients, shadows, micro-animations
- Dark mode support (optional but impressive)

### Step 8.2 — Error Handling & Edge Cases
- Handle empty states gracefully (no entries, no goal set, no height entered)
- Network error handling for auth operations
- Initialize `firebase_crashlytics` in `main.dart`

### Step 8.3 — Fix the Typo
- Rename `features/weight_tracking/domain/usescases/` → `usecases/`

### Step 8.4 — Testing
- Unit tests for `WeightEntryService` (CRUD + trend calculation)
- Unit tests for `WeightTrackingCubit` (state transitions)
- Widget tests for key screens

---

## Quick Reference: Packages You'll Need to Add

| Package | For What | Command |
|---------|----------|---------|
| `fl_chart` | Line charts on Dashboard & Insights | `flutter pub add fl_chart` |
| `path_provider` | File system paths for CSV export | `flutter pub add path_provider` |
| `share_plus` | Share CSV files | `flutter pub add share_plus` |
| `file_picker` | Pick CSV files for import | `flutter pub add file_picker` |
| `flutter_local_notifications` | Daily weight reminders | `flutter pub add flutter_local_notifications` |
| `intl` | Date/time formatting | `flutter pub add intl` |

---

## The Build Order at a Glance

```
Phase 1: Fix Routing ───────────────────► You can navigate between screens
    ↓
Phase 2: Weight Tracking Cubit ─────────► State management is ready
    ↓
Phase 3: Dashboard (HomeScreen) ────────► Users see their data
    ↓
Phase 4: History Screen ────────────────► Users can browse/edit/delete entries
    ↓
Phase 5: Bottom Navigation ─────────────► All screens connected
    ↓
Phase 6: Insights Screen ──────────────► BMI, milestones, charts
    ↓
Phase 7: Settings Screen ──────────────► CSV, notifications, profile
    ↓
Phase 8: Polish ────────────────────────► Beautiful, tested, production-ready
```

> [!IMPORTANT]
> **Start with Phase 1 (routing)** — without it, you can't reach any new screens you build. Then Phase 2 (cubit) — without state management, your UI has no way to talk to the database cleanly.
