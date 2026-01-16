import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_text_styles.dart';
import 'routes/app_routes.dart';
import 'routes/route_generator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'App',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: ThemeData(
            fontFamily: AppTextStyles.fontFamily,
            textTheme: TextTheme(
              displayLarge: AppTextStyles.titleHeader1(),
              displayMedium: AppTextStyles.header2(),
              displaySmall: AppTextStyles.header3(),
              titleLarge: AppTextStyles.subtitle(),
              bodyLarge: AppTextStyles.bodyMedium(),
              bodyMedium: AppTextStyles.bodyRegular(),
              bodySmall: AppTextStyles.small(),
              labelLarge: AppTextStyles.buttonText(),
            ),
          ),
        );
      },
    );
  }
}
