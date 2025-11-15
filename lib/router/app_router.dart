/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/screen/screen_splash.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey();

class AppRouter {
  static const String screenSplash = "/screenSplash";
  static const String screenUserList = "/screenUserList";
  static const String screenUserDetails = "/screenUserDetails";
}

final GoRouter appRouter = GoRouter(
  navigatorKey: navigator,
  initialLocation: AppRouter.screenSplash,
  routes: [
    GoRoute(
      path: AppRouter.screenSplash,
      builder: (context, state) => ScreenSplash(),
    ),
  ],
);
