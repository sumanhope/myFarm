import 'package:get/get.dart';
import 'package:myfarm/data/repositories/productrepo.dart';
import 'package:myfarm/features/store/models/productmodal.dart';
import 'package:myfarm/utils/popus/loader.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final productrepo = Get.put(ProductRepo());
  RxList<ProductModel> featureProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();

    super.onInit();
  }

  fetchFeaturedProducts() async {
    try {
      final products = await productrepo.getFeaturedProducts();

      featureProducts.assignAll(products);
    } catch (e) {
      MFLoader.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}
