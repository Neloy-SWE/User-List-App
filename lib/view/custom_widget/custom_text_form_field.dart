/* 
Created by Neloy on 16 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../utility/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final String hint;
  final String label;
  final void Function(String)? onFieldSubmitted;
  final IconData? suffix;
  final void Function()? suffixOnTap;

  const CustomTextFormField({
    super.key,
    this.validator,
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
    this.onChanged,
    this.hint = "",
    this.label = "",
    this.onFieldSubmitted,
    this.suffix,
    this.suffixOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final styleText = Theme.of(context).textTheme;
    return TextFormField(
      style: styleText.bodyMedium,
      validator: validator,
      controller: controller,
      keyboardType: textInputType,
      cursorColor: AppColor.colorPrimary,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: AppColor.colorError,
          fontSize: 10,
        ),
        contentPadding: EdgeInsets.all(10),
        alignLabelWithHint: true,
        suffixIcon: InkWell(
          onTap: suffixOnTap,
          child: Icon(suffix, color: AppColor.colorPrimary),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5, color: Colors.black),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColor.colorPrimary),
          borderRadius: BorderRadius.circular(7),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColor.colorError),
          borderRadius: BorderRadius.circular(7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5, color: Colors.black),
          borderRadius: BorderRadius.circular(7),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black54),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColor.colorError),
          borderRadius: BorderRadius.circular(7),
        ),

        hintText: hint,
        labelText: label,

        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.black38),
        labelStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
