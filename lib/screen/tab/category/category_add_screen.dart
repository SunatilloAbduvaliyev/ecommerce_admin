import 'package:admin_ecommerce/data/image_repository.dart';
import 'package:admin_ecommerce/data/model/category_model/category_model.dart';
import 'package:admin_ecommerce/screen/tab/category/view_model/category_view_model.dart';
import 'package:admin_ecommerce/screen/tab/category/widget/add_button.dart';
import 'package:admin_ecommerce/screen/tab/category/widget/image_dialog.dart';
import 'package:admin_ecommerce/screen/tab/category/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../utils/color/app_colors.dart';
import '../../../utils/images/app_images.dart';

class CategoryAddScreen extends StatefulWidget {
  const CategoryAddScreen({
    super.key,
    required this.renameCategory,
    required this.isAddProduct,
  });

  final CategoryModel renameCategory;
  final bool isAddProduct;

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  CategoryModel categoryModel = CategoryModel.initialValue;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  int active = -1;
  String image = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _init() {
    if (widget.renameCategory.title.isNotEmpty && widget.isAddProduct) {
      titleController =
          TextEditingController(text: widget.renameCategory.title);
      descriptionController =
          TextEditingController(text: widget.renameCategory.description);
      image = widget.renameCategory.image;
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("------------------------------------------build runa");
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Card(
                    color: AppColors.c252A41,
                    child: Column(
                      children: [
                        Ink(
                          width: double.infinity,
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: AppColors.c252A41,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: InkWell(
                            onTap: () {
                              showImageDialog(
                                activeIndex: (value) {
                                  active = value;
                                  debugPrint('------------------------$active');
                                },
                                imageChanged: (images) {
                                  setState(() {
                                    categoryModel.copyWith(
                                      image: image,
                                    );
                                    image = images;
                                    debugPrint(
                                        '------------------------$image');
                                  });
                                },
                                active: active,
                                context: context,
                              );
                            },
                            borderRadius: BorderRadius.circular(16.r),
                            child: image.isEmpty
                                ? Center(
                                    child: Image.asset(
                                      AppImages.downloadImage,
                                      color: Colors.white,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        textField(
                          title: "Title",
                          isTitle: true,
                          controller: titleController,
                        ),
                        widget.isAddProduct?const SizedBox():textField(
                          title: "Price",
                          controller: priceController,
                        ),
                        textField(
                          title: "Description",
                          controller: descriptionController,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                addButton(
                    title: widget.renameCategory.title.isEmpty
                        ? 'Add Categories'
                        : 'Rename Categories',
                    onTap: () {
                      if (widget.renameCategory.title.isEmpty) {
                        if (formKey.currentState!.validate() && active != -1) {
                          context.read<CategoryViewModel>().insertCategory(
                              CategoryModel(
                                title: titleController.text,
                                description: descriptionController.text,
                                image: imageUrl[active],
                              ),
                              context);
                          Navigator.of(context).pop();
                        }
                      } else {
                        if (formKey.currentState!.validate()) {
                          context.read<CategoryViewModel>().updateCategory(
                              CategoryModel(
                                docId: widget.renameCategory.docId,
                                title: titleController.text,
                                description: descriptionController.text,
                                image: active != -1
                                    ? imageUrl[active]
                                    : widget.renameCategory.image,
                              ),
                              context);
                          Navigator.of(context).pop();
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}