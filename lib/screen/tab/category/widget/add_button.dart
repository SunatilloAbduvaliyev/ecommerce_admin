import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/style/app_text_style.dart';

addButton({
  required VoidCallback onTap,
  required String title,
}) {
  return Ink(
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.c2563EB,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.semiBold
                .copyWith(fontSize: 20.sp, letterSpacing: 3),
          ),
        ),
      ),
    ),
  );
}
