/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user_list_app/view/utility/app_color.dart';
import 'package:user_list_app/view/utility/app_size.dart';

import '../../router/app_router.dart';
import '../utility/app_text.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      context.replace(AppRouter.screenUserList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: AppBar(title: Text(AppText.welcome)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.contacts_outlined,
                    size: 100,
                    color: Colors.white,
                  ),
                  AppSize.gapH15,
                  Text(AppText.title, style: TextTheme.of(context).titleLarge),
                  AppSize.gapH10,
                  Text(
                    AppText.subtitle,
                    style: TextTheme.of(
                      context,
                    ).bodyMedium!.copyWith(color: Colors.white),
                  ),
                ],
              ),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
