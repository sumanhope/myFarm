import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/store/models/categorymodel.dart';
import 'package:myfarm/utils/exceptions/firebase_exceptions.dart';
import 'package:myfarm/utils/exceptions/format_exceptions.dart';
import 'package:myfarm/utils/exceptions/platform_exceptions.dart';

class CategoryRepo extends GetxController {
  static CategoryRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CatergoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("categories").get();
      final list = snapshot.docs.map((document) => CatergoryModel.fromSnapShot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw MFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MFFormatException();
    } on PlatformException catch (e) {
      throw MFPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, Please try again.";
    }
  }
}
