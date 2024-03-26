import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../../../utils/style/app_text_style.dart';


textField({
  required TextEditingController controller,
  bool isTitle = false,
  required String title,
}){
  return TextFormField(
    style: isTitle?AppTextStyle.semiBold.copyWith(
      fontSize: 24.sp,
      letterSpacing: 3,
    ):AppTextStyle.regular.copyWith(
      fontSize: 12.sp,
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    maxLines: null,
    maxLength: isTitle?50:100,
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Title is required';
      }
      return null;
    },
    decoration: InputDecoration(
      hintStyle: isTitle?AppTextStyle.semiBold.copyWith(
        fontSize: 24.sp,
        letterSpacing: 3,
      ):AppTextStyle.regular.copyWith(
        fontSize: 12.sp,
      ),
      hintText: title,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    ),
  );
}