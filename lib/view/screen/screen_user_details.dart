/* 
Created by Neloy on 16 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:user_list_app/network/model/model_user_list.dart';
import 'package:user_list_app/view/custom_widget/custom_profile_image_view.dart';
import 'package:user_list_app/view/utility/app_size.dart';
import 'package:user_list_app/view/utility/app_text.dart';

class ScreenUserDetails extends StatelessWidget {
  final User user;

  const ScreenUserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.userDetails)),
      body: ListView(
        padding: MediaQuery.of(context).size.width > 750
            ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.2, vertical: 35) : EdgeInsets.all(25),
        physics: BouncingScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: CustomProfileImageView(radius: 50, imageLink: user.avatar!),
          ),
          AppSize.gapH20,
          Text(
            "${user.firstName!} ${user.lastName!}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Divider(color: Colors.black),
          AppSize.gapH20,
          optionText(
            context: context,
            option: AppText.emailColon,
            result: user.email!,
          ),
          optionText(
            context: context,
            option: AppText.phoneColon,
            result: "N/A",
          ),
        ],
      ),
    );
  }

  Widget optionText({
    required BuildContext context,
    required String option,
    required String result,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      color: Colors.black12,
      child: Row(
        children: [
          Text(option, style: Theme.of(context).textTheme.bodyLarge),
          Text(result, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
