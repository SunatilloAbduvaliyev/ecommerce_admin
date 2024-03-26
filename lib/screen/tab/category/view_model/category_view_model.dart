import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/model/category_model/category_model.dart';
import '../../../../utils/utility_functions.dart';

class CategoryViewModel extends ChangeNotifier {
  bool isLoading = false;

  Stream<List<CategoryModel>> getAllCategories() =>
      FirebaseFirestore.instance.collection("categories").snapshots().map(
            (event) => event.docs
                .map((e) => CategoryModel.fromJson(e.data()))
                .toList(),
          );

  Future<void> insertCategory(
      CategoryModel categoryModel, BuildContext context) async {
    try {
      _notify(true);
      var collectionReference =
          await FirebaseFirestore.instance.collection('categories').add(
                categoryModel.toJson(),
              );

      await FirebaseFirestore.instance
          .collection('categories')
          .doc(collectionReference.id)
          .update(
        {"id": collectionReference.id},
      );

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackBar(context: context, message: error.code);
    }
  }

  Future<void> updateCategory(
      CategoryModel categoryModel, BuildContext context) async {
    debugPrint("--------------------------------------------------------id -----------${categoryModel.docId}");
    try {
      _notify(true);
      debugPrint("--------------------------------------------------------id -----------${categoryModel.docId}");
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryModel.docId)
          .update(
            categoryModel.toJsonForUpdate(),
          );

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackBar(context: context, message: error.code);
    }
  }

  Future<void> deleteCategory(String docId, BuildContext context) async {
    try {
      _notify(true);

      await FirebaseFirestore.instance
          .collection('categories')
          .doc(docId)
          .delete();

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackBar(context: context, message: error.code);
    }
  }

  _notify(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
