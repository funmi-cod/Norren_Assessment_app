import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:norrenberger_app/base_widget.dart';
import 'package:norrenberger_app/common/constant/page_route.dart';
import 'package:norrenberger_app/common/constant/text_constant.dart';
import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';
import 'package:norrenberger_app/env/environment.dart';
import 'package:norrenberger_app/into_screen.dart';
import 'package:norrenberger_app/providers/multi_provider.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const String environment =
      String.fromEnvironment("ENVIRONMENT", defaultValue: Environment.DEV);

  Environment().initConfig(environment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(logicalWidth(), logicalHeight()),
        //) 375, 812,
        builder: (context, Widget? child) =>
            StreamProvider<InternetConnectionStatus>(
              initialData: InternetConnectionStatus.connected,
              create: (_) {
                return InternetConnectionChecker().onStatusChange;
              },
              child: MaterialApp(
                builder: (context, child) {
                  final MediaQueryData data = MediaQuery.of(context);
                  return MultiProvider(
                    providers: allProviders,
                    child: MediaQuery(
                      data: data.copyWith(
                        textScaler: const TextScaler.linear(1),
                      ),
                      child: BaseWidget(
                        child: child!,
                      ),
                    ),
                  );
                },
                navigatorKey: navigatorKey,
                title: TextLiterals.appName,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    primarySwatch: Colors.yellow,
                    fontFamily: 'SofiaSans',
                    bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor: AppColors.white,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: AppColors.white,
                    )),
                onGenerateRoute: AppRouter.generateRoute,
                home: const IntroScreen(),
              ),
            ));
  }
}
