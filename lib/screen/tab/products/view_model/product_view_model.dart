import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/model/product_model/product_model.dart';
import '../../../../utils/utility_functions.dart';

class ProductViewModel extends ChangeNotifier {
  bool isLoading = false;

  Stream<List<ProductModel>> getAllProduct() =>
      FirebaseFirestore.instance.collection("products").snapshots().map(
            (event) => event.docs
            .map((e) => ProductModel.fromJson(e.data()))
            .toList(),
      );

  Future<void> insertProduct(
      ProductModel categoryModel, BuildContext context) async {
    try {
      _notify(true);
      var collectionReference =
      await FirebaseFirestore.instance.collection('products').add(
        categoryModel.toJson(),
      );

      await FirebaseFirestore.instance
          .collection('products')
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

  Future<void> updateProduct(
      ProductModel categoryModel, BuildContext context) async {
    debugPrint("--------------------------------------------------------id -----------${categoryModel.docId}");
    try {
      _notify(true);
      debugPrint("--------------------------------------------------------id -----------${categoryModel.docId}");
      await FirebaseFirestore.instance
          .collection('products')
          .doc(categoryModel.docId)
          .update(
        categoryModel.toUpdateJson(),
      );

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackBar(context: context, message: error.code);
    }
  }

  Future<void> deleteProduct(String docId, BuildContext context) async {
    try {
      _notify(true);

      await FirebaseFirestore.instance
          .collection('products')
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
