import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/data/repositories/authentication_repo.dart';
import 'package:myfarm/data/repositories/user/userrepo.dart';
import 'package:myfarm/features/authentication/models/usermodel.dart';
import 'package:myfarm/features/authentication/screens/emailverfication.dart';
import 'package:myfarm/utils/popus/loader.dart';
import 'package:myfarm/utils/popus/screenloader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacypolicy = true.obs;
  final email = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final phonenumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    try {
      showDialog(
          context: Get.overlayContext!,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          });

      if (!privacypolicy.value) {
        Navigator.pop(Get.overlayContext!);
        MFLoader.warningSnackBar(title: "Accept Privacy Policy", message: "In order to create account, you must accept the Privacy Policy and Terms of use");
        return;
      }
      final userCredential = await AuthenticationRepo.instance.emailandpassword(email.text.trim(), password.text.trim());

      final newuser = UserModel(
        id: userCredential.user!.uid,
        firstname: firstname.text.trim(),
        lastname: lastname.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phonenumber: phonenumber.text.trim(),
        profilepicture: '',
      );

      final userrepo = Get.put(UserRepo());
      await userrepo.saveUserRecord(newuser);

      MFLoader.sucessSnackBar(title: "Congratulations!", message: "Your account has been created.");
      Get.to(
        () => EmailVerificationScreen(
          email: email.text.trim(),
        ),
      );
    } catch (e) {
      ScreenLoader.stopLoadingDialog();
      MFLoader.errorSnackBar(title: 'Oh NO!', message: e.toString());
    }
  }
}
