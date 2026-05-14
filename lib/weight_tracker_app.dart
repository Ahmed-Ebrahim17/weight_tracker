import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/di/dependency_injection.dart';
import 'package:weight_tracker/core/routing/app_router.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_state.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';

class WeightTrackerApp extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
        return BlocProvider<AuthCubit>(
          create: (context) => getIt<AuthCubit>()..loadCurrentUser(),
          child: BlocProvider<WeightTrackingCubit>(
            create: (context) => getIt<WeightTrackingCubit>(),
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  context.read<WeightTrackingCubit>().loadDashboardData();
                } else if (state is AuthInitial) {
                  context.read<WeightTrackingCubit>().reset();
                  navigatorKey.currentState?.pushNamedAndRemoveUntil(
                    Routes.loginScreen,
                    (route) => false, // clears all previous routes
                  );
                }
              },
              child: MaterialApp(
                locale: DevicePreview.locale(context),
                builder: DevicePreview.appBuilder,
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
                navigatorKey: navigatorKey,
                initialRoute: initialRoute,
              ),
            ),
          ),
        );
      },
    );
  }
}
