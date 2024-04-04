import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myfarm/data/repositories/authentication_repo.dart';
import 'package:myfarm/features/personalization/models/addressmodal.dart';

class AddressRepo extends GetxController {
  static AddressRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final userId = AuthenticationRepo.instance.authuser!.uid;
      if (userId.isEmpty) throw 'Unable to find user information.';
      final result = await _db.collection('users').doc(userId).collection('Addresses').get();
      return result.docs.map((e) => AddressModel.fromDocumentSnapshot(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepo.instance.authuser!.uid;
      await _db.collection('users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepo.instance.authuser!.uid;
      final currentAddress = await _db.collection('users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw e.toString();
    }
  }
}
