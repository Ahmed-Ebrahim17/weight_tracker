import 'package:flutter/material.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class AppNameWithNotificationsIcon extends StatelessWidget {
  const AppNameWithNotificationsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.appName.split(' ')[0],
          style: AppTextStyles.font18ExtraBoldPrimaryDeepBlue,
        ),
        IconButton(
          onPressed: () {
            // TODO: Open Settings
          },
          icon: const Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }
}
