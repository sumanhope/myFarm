import 'package:get/get.dart';
import 'package:myfarm/features/store/models/cartmodel.dart';
import 'package:myfarm/features/store/models/productmodal.dart';

import 'package:myfarm/utils/local_storage/storage_utility.dart';
import 'package:myfarm/utils/popus/loader.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noofCartItems = 0.obs;
  RxInt totalCartPrice = 0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  CartController() {
    loadCartItems();
  }
  void addToCart(ProductModel product) {
    if (productQuantityInCart.value < 1) {
      MFLoader.currentToast(message: 'Select Quantity');
      return;
    }

    if (product.stock < 1) {
      MFLoader.warningSnackBar(title: "Error", message: "Product is out of stock");
      return;
    }

    final selectedCartItem = convertToCartItem(product, productQuantityInCart.value);
    int index = cartItems.indexWhere((element) => element.productId == selectedCartItem.productId);
    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    MFLoader.currentToast(message: "Product added to Cart.");
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((element) => element.productId == item.productId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeoneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((element) => element.productId == item.productId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
      }
    }
    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: "Remove Product",
      middleText: "Do you want to remove this product?",
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        Get.back();
        MFLoader.currentToast(message: "Produt removed for the Cart!");
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void updateAlreadyAddedProdcutCount(ProductModel product) {
    productQuantityInCart.value = getProductQuantityinCart(product.id);
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    return CartItemModel(
      categoryId: product.categoryId,
      productId: product.id,
      quantity: quantity,
      title: product.title,
      price: product.price,
      image: product.thumbnail,
      tag: product.tag,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    int calculatedTotalPrice = 0;
    int noofitems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity;
      noofitems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noofCartItems.value = noofitems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((element) => element.toJson()).toList();
    MFLocalStorage.instance().writeData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings = MFLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityinCart(String productId) {
    final founditem = cartItems.where((p0) => p0.productId == productId).fold(0, (previousValue, element) => previousValue + element.quantity);
    return founditem;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
