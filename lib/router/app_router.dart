/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_list_app/bloc/bloc_get_user_list/bloc_get_user_list.dart';
import 'package:user_list_app/dependency/service_injection.dart';
import 'package:user_list_app/network/connection_check/i_connection_check.dart';
import 'package:user_list_app/network/model/model_user_list.dart';
import 'package:user_list_app/network/repository/repository_get_user_list/i_repository_get_user_list.dart';
import 'package:user_list_app/view/screen/screen_user_details.dart';

import '../view/screen/screen_splash.dart';
import '../view/screen/screen_user_list.dart';

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

    GoRoute(
      path: AppRouter.screenUserList,
      builder:
          (context, state) => BlocProvider<BlocGetUserList>(
            create:
                (_) => BlocGetUserList(
                  repositoryGetUserList:
                      serviceInjector<IRepositoryGetUserList>(),
                  connectionCheck: serviceInjector<IConnectionCheck>(),
                ),
            child: ScreenUserList(),
          ),
    ),
    GoRoute(
      path: AppRouter.screenUserDetails,
      builder: (context, state) {
        final user = state.extra as User;
        return ScreenUserDetails(user: user);
      },
    ),
  ],
);
