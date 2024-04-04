import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/store/models/productmodal.dart';

class ProductRepo extends GetxController {
  static ProductRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('products').where('IsFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('products').get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductModel>> fetchProductbyQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs.map((e) => ProductModel.fromQuerySnapshot(e)).toList();
      return productList;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductModel>> getFavProducts(List<String> productIds) async {
    try {
      final snapshot = await _db.collection('products').where(FieldPath.documentId, whereIn: productIds).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
