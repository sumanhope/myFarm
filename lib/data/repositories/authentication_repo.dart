import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfarm/features/authentication/screens/emailverfication.dart';
import 'package:myfarm/features/authentication/screens/login.dart';
import 'package:myfarm/features/authentication/screens/onboarding.dart';
import 'package:myfarm/main.dart';
import 'package:myfarm/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:myfarm/utils/exceptions/firebase_exceptions.dart';
import 'package:myfarm/utils/exceptions/format_exceptions.dart';
import 'package:myfarm/utils/exceptions/platform_exceptions.dart';
import 'package:myfarm/utils/local_storage/storage_utility.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authuser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        await MFLocalStorage.init(user.uid);
        Get.offAll(() => const LandingPage());
      } else {
        Get.offAll(() => EmailVerificationScreen(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull("isFirstTime", true);
      deviceStorage.read("isFirstTime") != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(
              () => const OnBoardingScreen(),
            );
    }
  }

  // Register
  Future<UserCredential> emailandpassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw MFFirebaseAuthException(e.code).message;
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
