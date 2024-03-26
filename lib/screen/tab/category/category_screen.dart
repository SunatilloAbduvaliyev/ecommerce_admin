import 'package:admin_ecommerce/routes.dart';
import 'package:admin_ecommerce/screen/tab/category/view_model/category_view_model.dart';
import 'package:admin_ecommerce/screen/tab/category/widget/category_button.dart';
import 'package:admin_ecommerce/utils/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../data/model/category_model/category_model.dart';
import '../../../utils/images/app_images.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Category qo'shing",
            style: AppTextStyle.medium,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.categoryAddScreen,
                    arguments: {
                      'categoryModel': CategoryModel.initialValue,
                      'isAddProduct': true,
                    },
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: StreamBuilder<List<CategoryModel>>(
          stream: context.read<CategoryViewModel>().getAllCategories(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              List<CategoryModel> categoryList =
                  snapshot.data as List<CategoryModel>;
              return categoryList.isEmpty
                  ? Center(child: Lottie.asset(AppImages.categoryLottie))
                  : ListView.builder(
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        CategoryModel category = categoryList[index];
                        return Dismissible(
                          key: ValueKey<String>(category.title),
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Deleting'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: const Text('No'),
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                RouteName.categoryAddScreen,
                                arguments: {
                                  'categoryModel': category,
                                  'isAddProduct': true,
                                },
                              );
                            }
                            return null;
                          },
                          onDismissed: (direction) async {
                            await context
                                .read<CategoryViewModel>()
                                .deleteCategory(
                                  category.docId!,
                                  context,
                                );
                          },
                          background: Container(
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            color: Colors.red,
                            child: Center(
                              child: Text(
                                "Deleting",
                                style: AppTextStyle.semiBold.copyWith(
                                    fontSize: 40.sp, letterSpacing: 10),
                              ),
                            ),
                          ),
                          secondaryBackground: Container(
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                "Rename",
                                style: AppTextStyle.semiBold.copyWith(
                                    fontSize: 40.sp, letterSpacing: 10),
                              ),
                            ),
                          ),
                          child: categoryButton(
                            category: category,
                            onTab: () {
                              Navigator.pushNamed(
                                context,
                                RouteName.categoryAddScreen,
                                arguments: {
                                  'categoryModel': category,
                                  'isAddProduct': false,
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
