import 'package:get/get.dart';
import 'package:myfarm/data/repositories/productrepo.dart';
import 'package:myfarm/features/personalization/controllers/addresscontroller.dart';
import 'package:myfarm/features/personalization/controllers/favcontroller.dart';
import 'package:myfarm/features/store/controllers/allproductcontrollers.dart';
import 'package:myfarm/features/store/controllers/checkoutcontroller.dart';
import 'package:myfarm/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(FavoriteController());
    Get.put(ProductRepo());
    Get.put(AllProductController());
  }
}
