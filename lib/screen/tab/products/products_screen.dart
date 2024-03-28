import 'package:admin_ecommerce/data/model/category_model/category_model.dart';
import 'package:admin_ecommerce/screen/tab/products/view_model/product_view_model.dart';
import 'package:admin_ecommerce/utils/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../data/model/product_model/product_model.dart';
import '../../../utils/color/app_colors.dart';
import '../../../utils/images/app_images.dart';
import '../../service.dart';
import '../category/category_add_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<ProductModel>>(
      stream: context.read<ProductViewModel>().getAllProduct(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          List<ProductModel> productList = snapshot.data as List<ProductModel>;
          return productList.isEmpty
              ? Center(child: Lottie.asset(AppImages.categoryLottie))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      mainAxisSpacing: 10.0, // Spacing between rows
                      crossAxisSpacing: 10.0, // Spacing between columns
                      childAspectRatio: 0.7, // Aspect ratio of each grid item
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration:
                            const BoxDecoration(color: AppColors.c252A41),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              productList[index].image,
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            ),
                            Text(
                              productList[index].title,
                              style: AppTextStyle.semiBold,
                            ),
                            Text(
                              productList[index].description,
                              style: AppTextStyle.regular,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "\$${productList[index].price}",
                                  style: AppTextStyle.regular,
                                )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryAddScreen(
                                                      isAddProduct: false,
                                                      productModel:
                                                          productList[index],
                                                      renameCategory:
                                                          CategoryModel
                                                              .initialValue)));
                                    },
                                    icon: const Icon(
                                        Icons.drive_file_rename_outline,
                                        color: Colors.green)),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<ProductViewModel>()
                                          .deleteProduct(
                                              productList[index].docId!,
                                              context);
                                      LocalNotificationService()
                                          .showNatification(
                                        title: "Product deleted",
                                        body: "Ma'lumot saqlandi",
                                        id: 522,
                                      );
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red))
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
