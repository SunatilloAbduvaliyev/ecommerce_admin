import 'package:admin_ecommerce/screen/permission.dart';
import 'package:admin_ecommerce/screen/tab/category/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../data/model/category_model/category_model.dart';
import '../../../utils/images/app_images.dart';
import '../category/widget/category_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PermissionsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios)
          )
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
                    return categoryButton(
                      category: category,
                      onTab: () {},
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
