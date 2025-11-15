/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:user_list_app/view/utility/app_color.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: AppBar(),
      body: Container(),
    );
  }
}
