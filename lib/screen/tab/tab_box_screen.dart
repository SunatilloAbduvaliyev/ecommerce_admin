import 'package:admin_ecommerce/screen/tab/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color/app_colors.dart';
import 'category/category_screen.dart';
import 'home/home_screen.dart';
class TabBoxScreen extends StatefulWidget {
  const TabBoxScreen({super.key});

  @override
  State<TabBoxScreen> createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          CategoryScreen(),
          ProductsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        backgroundColor: AppColors.c252A41,
        items:  [
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.home_filled, color: AppColors.cBBF7D0,size: 30.w,),
            icon: Icon(Icons.home_filled, color: Colors.white,size: 30.w,)
          ),
          BottomNavigationBarItem(
            label: '',
              activeIcon: Icon(Icons.category, color: AppColors.cBBF7D0,size: 30.w,),
              icon: Icon(Icons.category, color: Colors.white,size: 30.w,)
          ),
          BottomNavigationBarItem(
            label: '',
              activeIcon: Icon(Icons.shopping_bag_rounded, color: AppColors.cBBF7D0,size: 30.w,),
              icon: Icon(Icons.shopping_bag_rounded, color: Colors.white,size: 30.w,)
          )
        ],
      ),
    );
  }
}
