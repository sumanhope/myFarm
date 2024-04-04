import 'dart:convert';

import 'package:get/get.dart';
import 'package:myfarm/data/repositories/productrepo.dart';
import 'package:myfarm/features/store/models/productmodal.dart';
import 'package:myfarm/utils/local_storage/storage_utility.dart';
import 'package:myfarm/utils/popus/loader.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  final favorites = <String, bool>{}.obs;
  @override
  void onInit() {
    super.onInit();
    initFav();
  }

  void initFav() {
    final json = MFLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFav = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
        storedFav.map(
          (key, value) => MapEntry(key, value as bool),
        ),
      );
    }
  }

  bool isFav(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFav(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavToStorage();
      favorites.refresh();
      MFLoader.currentToast(message: 'Product has been added to the WhishList');
    } else {
      MFLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavToStorage();
      favorites.refresh();
      MFLoader.currentToast(message: 'Product has been removed from the WhishList');
    }
  }

  void saveFavToStorage() {
    final encodedFav = json.encode(favorites);
    MFLocalStorage.instance().writeData('favorites', encodedFav);
  }

  Future<List<ProductModel>> favProducts() async {
    if (favorites.isNotEmpty) {
      // Only call getFavProducts if favorites map is not empty
      return await ProductRepo.instance.getFavProducts(favorites.keys.toList());
    } else {
      // Handle case when favorites map is empty
      // You might want to return an empty list or handle it differently based on your application logic
      return [];
    }
  }
}
