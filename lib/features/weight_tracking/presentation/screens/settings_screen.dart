import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/settings/settings_card.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/settings/settings_divider.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/settings/settings_nav_tile.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/settings/settings_section_label.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/settings/settings_segment_tile.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/settings/settings_toggle_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // 0 = lbs, 1 = kg
  int _unitIndex = 0;
  // 0 = Light, 1 = Dark
  int _themeIndex = 0;
  bool _dailyReminderEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.veryLightGray,
      appBar: AppBar(
        title: Text('Settings', style: AppTextStyles.font20BoldVeryDarkGray),
        automaticallyImplyLeading: false,
        backgroundColor: ColorsManager.veryLightGray,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── GOALS ──────────────────────────────────────────────────────
            const SettingsSectionLabel('Goals'),
            SettingsCard(
              children: [
                SettingsNavTile(
                  icon: Icons.track_changes_outlined,
                  title: 'Target Weight',
                  trailingText: '165.0 lbs',
                  iconBackgroundColor: ColorsManager.primaryDeepBlue,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 28.h),

            // ── PREFERENCES ────────────────────────────────────────────────
            const SettingsSectionLabel('Preferences'),
            SettingsCard(
              children: [
                SettingsSegmentTile(
                  icon: Icons.straighten_outlined,
                  title: 'Units',
                  options: const ['lbs', 'kg'],
                  selectedIndex: _unitIndex,
                  onSelected: (i) => setState(() => _unitIndex = i),
                ),
                const SettingsDivider(),
                SettingsSegmentTile(
                  icon: Icons.contrast_outlined,
                  title: 'Theme',
                  options: const ['Light', 'Dark'],
                  selectedIndex: _themeIndex,
                  onSelected: (i) => setState(() => _themeIndex = i),
                ),
                const SettingsDivider(),
                SettingsNavTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  trailingText: 'English',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 28.h),

            // ── NOTIFICATIONS ──────────────────────────────────────────────
            const SettingsSectionLabel('Notifications'),
            SettingsCard(
              children: [
                SettingsToggleTile(
                  icon: Icons.alarm_outlined,
                  title: 'Daily Reminder',
                  subtitle: '8:00 AM',
                  iconBackgroundColor: ColorsManager.secondary,
                  value: _dailyReminderEnabled,
                  onChanged: (val) => setState(() => _dailyReminderEnabled = val),
                ),
              ],
            ),
            SizedBox(height: 28.h),

            // ── ACCOUNT ────────────────────────────────────────────────────
            const SettingsSectionLabel('Account'),
            SettingsCard(
              children: [
                _SignOutButton(
                  onTap: () => context.read<AuthCubit>().logout(),
                ),
              ],
            ),
            SizedBox(height: 80.h), // nav bar clearance
          ],
        ),
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout, color: ColorsManager.red, size: 20.w),
              SizedBox(width: 10.w),
              Text(
                'Sign Out',
                style: AppTextStyles.font16RegularNearBlack.copyWith(
                  color: ColorsManager.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
