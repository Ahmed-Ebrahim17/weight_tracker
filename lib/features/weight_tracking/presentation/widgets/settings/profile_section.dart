import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.select((AuthCubit cubit) => cubit.currentUserName);
    final currentUser = context.read<AuthCubit>().currentUser;
    final email = currentUser?.email ?? '';

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorsManager.moreLighterGray, width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: ColorsManager.lightOrange,
            child: Text(
              userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
              style: AppTextStyles.font24BoldNearBlack.copyWith(
                color: ColorsManager.darkOrange,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName.isNotEmpty ? userName : 'User',
                  style: AppTextStyles.font18BoldVeryDarkGray,
                ),
                SizedBox(height: 4.h),
                Text(
                  email,
                  style: AppTextStyles.font14RegularDarkGray,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
