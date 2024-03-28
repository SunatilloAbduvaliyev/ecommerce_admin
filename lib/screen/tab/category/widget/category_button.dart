import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/category_model/category_model.dart';
import '../../../../utils/color/app_colors.dart';
import '../../../../utils/style/app_text_style.dart';
categoryButton({
  required CategoryModel category,
  required VoidCallback onTab,
}){
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Ink(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.c252A41,
      ),
      child: InkWell(
          onTap: onTab,
          child: ListTile(
            style: ListTileStyle.drawer,
            leading: Image.network(
              category.image,
              fit: BoxFit.cover,
              width: 100,
            ),
            title: Text(
              category.title,
              style: AppTextStyle.medium.copyWith(
                fontSize: 20.sp,
              ),
            ),
            subtitle: Text(
              category.description,
              style: AppTextStyle.regular.copyWith(
                fontSize: 12.sp,
              ),
            ),
          )),
    ),
  );
}