import 'package:admin_ecommerce/screen/tab/category/category_add_screen.dart';
import 'package:admin_ecommerce/screen/tab/category/category_screen.dart';
import 'package:admin_ecommerce/screen/tab/home/home_screen.dart';
import 'package:admin_ecommerce/screen/tab/products/products_screen.dart';
import 'package:admin_ecommerce/screen/tab/tab_box_screen.dart';
import 'package:flutter/material.dart';

import 'data/model/category_model/category_model.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return navigate(const TabBoxScreen());
      case RouteName.homeScreen:
        return navigate(const HomeScreen());

      case RouteName.categoryScreen:
        return navigate(const CategoryScreen());

      case RouteName.productScreen:
        return navigate(const ProductsScreen());

      case RouteName.categoryAddScreen:
        {
          Map data =
              settings.arguments as Map<dynamic, dynamic>;
          CategoryModel categoryModel = data['categoryModel'] as CategoryModel;
          bool isAddProduct = data['isAddProduct'];
          return navigate(
            CategoryAddScreen(
              renameCategory: categoryModel,
              isAddProduct: isAddProduct,
            ),
          );
        }

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text('Not Found '),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);
}

class RouteName {
  static const String splashScreen = '/';
  static const String homeScreen = '/home';
  static const String categoryScreen = '/category';
  static const String productScreen = '/product';
  static const String categoryAddScreen = '/add_category';
}
