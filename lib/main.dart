/*
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:user_list_app/dependency/service_injection.dart';
import 'package:user_list_app/router/app_router.dart';
import 'package:user_list_app/view/utility/app_text.dart';
import 'package:user_list_app/view/utility/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: AppTheme.get,
        title: AppText.title,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.noScaling),
            child: child!,
          );
        },
      ),
    );
  }
}
