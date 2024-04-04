import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myfarm/data/repositories/authentication_repo.dart';
import 'package:myfarm/features/authentication/models/usermodel.dart';
import 'package:myfarm/utils/exceptions/firebase_exceptions.dart';
import 'package:myfarm/utils/exceptions/format_exceptions.dart';
import 'package:myfarm/utils/exceptions/platform_exceptions.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Register
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("users").doc(user.id).set(user.toJson());
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

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection("users").doc(AuthenticationRepo.instance.authuser?.uid).get();
      if (documentSnapshot.exists) {
        debugPrint("Fetch");
        return UserModel.fromSnapShot(documentSnapshot);
      } else {
        return UserModel(id: "", firstname: "", lastname: "", username: "", email: "", phonenumber: "", profilepicture: "");
      }
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

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("users").doc(updatedUser.id).set(updatedUser.toJson());
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

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("users").doc(AuthenticationRepo.instance.authuser?.uid).update(json);
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

  Future<void> removeuserRecord(String userId) async {
    try {
      await _db.collection("users").doc(userId).delete();
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
