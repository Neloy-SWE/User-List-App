/* 
Created by Neloy on 16 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_list_app/view/utility/app_size.dart';

import '../utility/app_color.dart';

class CustomProfileImageView extends StatelessWidget {
  final double radius;
  final Color colorBorder;
  final String imageLink;

  const CustomProfileImageView({
    super.key,
    required this.radius,
    this.colorBorder = AppColor.colorPrimary,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (radius * 2) + 4,
      width: (radius * 2) + 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: colorBorder, width: 1),
      ),
      child: Container(
        height: (radius * 2),
        width: (radius * 2),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // image: DecorationImage(
          //   image: NetworkImage(imageLink),
          //   fit: BoxFit.fill,
          // ),
        ),
        child: CachedNetworkImage(
          imageUrl: imageLink,
          fit: BoxFit.cover,
          placeholder: (context, url) => AppSize.noGap,
          errorWidget: (context, url, error) => AppSize.noGap,
        ),
      ),
    );
  }
}
