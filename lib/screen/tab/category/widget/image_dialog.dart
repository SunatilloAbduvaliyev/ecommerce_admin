import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/image_repository.dart';
import '../../../../utils/color/app_colors.dart';

showImageDialog({
  required BuildContext context,
  required ValueChanged<int> activeIndex,
  required ValueChanged<String> imageChanged,
  required int active
}){
  return showDialog(context: context, builder: (context){
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.only(top:30.h,left: 10.w,right: 10.w, bottom: 10.h),
            margin: EdgeInsets.symmetric(vertical: 100.h, horizontal: 10.w),
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)
                )
            ),
            child: GridView.builder(
              itemCount: imageUrl.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.w,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: GestureDetector(
                        onTap: () {
                          active = index;
                          setState(() {});
                          activeIndex.call(active);
                          imageChanged.call(imageUrl[index]);
                          Navigator.of(context).pop();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            imageUrl[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: active == index
                            ? const Icon(
                          Icons.check,
                          color: Colors.red,
                        )
                            : const SizedBox())
                  ],
                );
              },
            )
        );
      },
    );
  });
}