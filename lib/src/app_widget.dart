import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sundaymart/src/riverpod/gh.dart';

import 'core/di/dependency_manager.dart';
import 'riverpod/provider/app_provider.dart';

class AppWidget extends ConsumerWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldMessengerKey,
          routerDelegate: appRouter.delegate(
              initialRoutes: [PageRouteInfo("SplashRoute", path: '/')]),

          routeInformationParser: appRouter.defaultRouteParser(),
          locale: ref
              .watch(appModelProvider)
              .activeLanguage, // Set your desired default locale
          supportedLocales: [
            const Locale('en', ''),
            const Locale('ar', ''),
            // Add more locales if needed
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // Add more localizations delegates if needed
            GlobalCupertinoLocalizations.delegate,
          ],
          themeMode: ref.watch(appProvider).isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          // Add your theme customization here
        );
      },
    );
  }
}
