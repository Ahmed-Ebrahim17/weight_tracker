import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/dashboard_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/history_screen.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static const _screens = <Widget>[
    DashboardScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 3) {
      context.pushNamed(Routes.addWeightScreen);
      return;
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _AppBottomNavBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Navigation Bar ───────────────────────────────────────────────────

class _AppBottomNavBar extends StatelessWidget {
  const _AppBottomNavBar({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
        child: Container(
          height: 56.h,
          padding: EdgeInsets.only(left: 12.w, right: 6.w),
          decoration: BoxDecoration(
            color: ColorsManager.surface,
            borderRadius: BorderRadius.circular(32.r),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.surface.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // ── Nav icons take up available space ──
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NavItem(
                      icon: Icons.home_outlined,
                      isSelected: currentIndex == 0,
                      onTap: () => onTap(0),
                    ),
                    _NavItem(
                      icon: Icons.bar_chart_rounded,
                      isSelected: currentIndex == 1,
                      onTap: () => onTap(1),
                    ),
                    _NavItem(
                      icon: Icons.settings_outlined,
                      isSelected: currentIndex == 2,
                      onTap: () => onTap(2),
                    ),
                  ],
                ),
              ),
              // ── Add button pinned to the right ──
              GestureDetector(
                onTap: () => onTap(3),
                child: Container(
                  width: 42.h,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: ColorsManager.surface,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 2.w),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Regular Nav Item ────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? ColorsManager.primaryBlue
        : ColorsManager.primaryBlue.withValues(alpha: 0.4);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Icon(icon, color: color, size: 22.sp),
      ),
    );
  }
}
