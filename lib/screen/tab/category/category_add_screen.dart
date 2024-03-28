import 'package:admin_ecommerce/data/model/category_model/category_model.dart';
import 'package:admin_ecommerce/screen/tab/category/view_model/category_view_model.dart';
import 'package:admin_ecommerce/screen/tab/category/widget/add_button.dart';
import 'package:admin_ecommerce/screen/tab/category/widget/text_field.dart';
import 'package:admin_ecommerce/screen/tab/products/view_model/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../data/model/product_model/product_model.dart';
import '../../../utils/color/app_colors.dart';
import '../../../utils/images/app_images.dart';
import '../../../view_model/image_view_model/image_view_model.dart';
import '../../service.dart';

class CategoryAddScreen extends StatefulWidget {
  const CategoryAddScreen({
    super.key,
    required this.renameCategory,
    required this.isAddProduct,
    this.productModel,
  });

  final CategoryModel renameCategory;
  final bool isAddProduct;
  final ProductModel? productModel;

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
    } else {
      titleController = TextEditingController(text: widget.productModel!.title);
      descriptionController =
          TextEditingController(text: widget.productModel!.description);
      image = widget.productModel!.image;
      priceController = TextEditingController(text: widget.productModel!.price);
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

  int id = 0;
  final ImagePicker picker = ImagePicker();

  String imageUrl = "";
  String storagePath = "";

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
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          await _getImageFromGallery();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Galery'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await _getImageFromCamera();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Camera'),
                                      )
                                    ],
                                  ));
                                },
                              );
                            },
                            borderRadius: BorderRadius.circular(16.r),
                            child:context.watch<ImageViewModel>().getLoader?const CircularProgressIndicator():
                                imageUrl.isEmpty
                                ? Center(
                                    child: Image.asset(
                                      AppImages.downloadImage,
                                      color: Colors.white,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: Image.network(
                                      imageUrl,
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
                        widget.isAddProduct
                            ? const SizedBox()
                            : textField(
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
                  onTap: widget.isAddProduct
                      ? () {
                          if (widget.renameCategory.title.isEmpty) {
                            if (formKey.currentState!.validate() &&
                                active != -1) {
                              context.read<CategoryViewModel>().insertCategory(
                                  CategoryModel(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    image: imageUrl[active],
                                  ),
                                  context);
                              LocalNotificationService.localNotificationService
                                  .showNatification(
                                title: "Category saqlandi buldi",
                                body: "Ma'lumotlar saqlandi",
                                id: id,
                              );
                              id++;
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
                              LocalNotificationService.localNotificationService
                                  .showNatification(
                                title: "Category update buldi",
                                body: "Ma'lumotlar saqlandi",
                                id: id,
                              );
                              id++;
                              Navigator.of(context).pop();
                            }
                          }
                        }
                      : () {
                          if (widget.productModel!.title.isEmpty) {
                            if (formKey.currentState!.validate() &&
                                active != -1) {
                              context.read<ProductViewModel>().insertProduct(
                                  ProductModel(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    image: imageUrl[active],
                                    price: priceController.text,
                                    categoryId: widget.renameCategory.docId,
                                  ),
                                  context);
                              LocalNotificationService.localNotificationService
                                  .showNatification(
                                title: "Product saqlandi buldi",
                                body: "Ma'lumotlar saqlandi",
                                id: id,
                              );
                              id++;
                              Navigator.of(context).pop();
                            }
                          } else {
                            context.read<ProductViewModel>().updateProduct(
                                  ProductModel(
                                      docId: widget.productModel!.docId,
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      image: active != -1
                                          ? imageUrl[active]
                                          : widget.productModel!.image,
                                      price: priceController.text),
                                  context,
                                );
                            LocalNotificationService.localNotificationService
                                .showNatification(
                              title: "Product update buldi",
                              body: "Ma'lumotlar saqlandi",
                              id: id,
                            );
                            id++;
                            Navigator.of(context).pop();
                          }
                        },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 200,
      maxWidth: double.infinity,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
            pickedFile: image,
            storagePath: storagePath,
          );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: double.infinity,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
            pickedFile: image,
            storagePath: storagePath,
          );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }
}
