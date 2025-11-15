/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:user_list_app/view/custom_widget/custom_button.dart';
import 'package:user_list_app/view/utility/app_color.dart';
import 'package:user_list_app/view/utility/app_text.dart';

import '../utility/app_size.dart';

class CustomDialogue {
  static result({
    required BuildContext context,
    required void Function()? onPressed,
    required String message,
    required String actionButtonText,
    bool isOnlyAction = false,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (builder) => Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: ListView(
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                AppSize.gapH20,
                isOnlyAction
                    ? CustomButton(
                      onPressed: onPressed,
                      buttonText: actionButtonText,
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            buttonText: AppText.leave,
                            colorButton: Colors.white,
                            textColor: AppColor.colorPrimary,
                          ),
                        ),
                        AppSize.gapW20,
                        Expanded(
                          child: CustomButton(
                            onPressed: onPressed,
                            buttonText: actionButtonText,
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
    );
  }
}
