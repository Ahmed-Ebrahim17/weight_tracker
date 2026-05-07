import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/routing/app_router.dart';
import 'package:weight_tracker/core/theming/colors.dart';

class WeightTrackerApp extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;

  const WeightTrackerApp({
    super.key,
    required this.appRouter,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: ColorsManager.veryLightGray,

            fontFamily: "Manrope",
            appBarTheme: AppBarTheme(
              backgroundColor: ColorsManager.veryLightGray,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
            ),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: initialRoute,
        );
      },
    );
  }
}
