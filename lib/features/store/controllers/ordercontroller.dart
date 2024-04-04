import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/data/repositories/authentication_repo.dart';
import 'package:myfarm/data/repositories/orderrepo.dart';
import 'package:myfarm/features/personalization/controllers/addresscontroller.dart';
import 'package:myfarm/features/store/controllers/cartcontroller.dart';
import 'package:myfarm/features/store/controllers/checkoutcontroller.dart';
import 'package:myfarm/features/store/models/ordermodel.dart';
import 'package:myfarm/features/store/screens/sucess.dart';
import 'package:myfarm/main.dart';
import 'package:myfarm/utils/popus/loader.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepo = Get.put(OrderRepo());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepo.fetchUserOrders();
      return userOrders;
    } catch (e) {
      MFLoader.warningSnackBar(title: "Error", message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      final userId = AuthenticationRepo.instance.authuser!.uid;
      if (userId.isEmpty) return;

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: "pending",
        items: cartController.cartItems.toList(),
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
      );

      await orderRepo.saveOrder(order, userId);

      cartController.clearCart();

      Get.off(
        () => SucessScreen(
          title: "Order Sucess",
          subtitle: "You item will be shipped soon!",
          func: () => Get.offAll(
            () => const LandingPage(),
          ),
        ),
      );
    } catch (e) {
      MFLoader.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}
