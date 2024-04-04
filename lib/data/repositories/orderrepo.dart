import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myfarm/data/repositories/authentication_repo.dart';
import 'package:myfarm/features/store/models/ordermodel.dart';

class OrderRepo extends GetxController {
  static OrderRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepo.instance.authuser!.uid;
      if (userId.isEmpty) throw 'Unable to find user information.';
      final result = await _db.collection('users').doc(userId).collection('Orders').get();
      return result.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db.collection('users').doc(userId).collection('Orders').doc(order.id).set(order.toJson());
    } catch (e) {
      throw e.toString();
    }
  }
}
