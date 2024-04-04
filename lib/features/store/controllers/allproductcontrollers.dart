import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myfarm/data/repositories/productrepo.dart';
import 'package:myfarm/features/store/models/productmodal.dart';
import 'package:myfarm/utils/popus/loader.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();
  final productrepo = ProductRepo.instance;
  RxList<ProductModel> featureProducts = <ProductModel>[].obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  @override
  void onInit() {
    fetchFeaturedProducts();

    super.onInit();
  }

  Future<List<ProductModel>> fetchProductbyQuery(Query? query) async {
    try {
      if (query == null) return [];
      final product = await productrepo.fetchProductbyQuery(query);
      return product;
    } catch (e) {
      MFLoader.errorSnackBar(title: "Error!", message: e.toString());
      return [];
    }
  }

  fetchFeaturedProducts() async {
    try {
      final products = await productrepo.getFeaturedProducts();

      featureProducts.assignAll(products);
    } catch (e) {
      MFLoader.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final products = await productrepo.getAllProducts();
      return products;
    } catch (e) {
      MFLoader.errorSnackBar(title: "Error", message: e.toString());
      return [];
    }
  }
}
