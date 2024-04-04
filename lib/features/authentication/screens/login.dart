import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:myfarm/admin/adminlogin.dart';
import 'package:myfarm/common/styles/spacing_styles.dart';
import 'package:myfarm/features/authentication/controllers/signup/logincontroller.dart';
import 'package:myfarm/features/authentication/screens/emailverfication.dart';
import 'package:myfarm/features/authentication/screens/forgotpassword.dart';
import 'package:myfarm/features/authentication/screens/signup.dart';
import 'package:myfarm/utils/constants/image_strings.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';
import 'package:myfarm/utils/popus/loader.dart';
import 'package:myfarm/utils/validators/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> login() async {
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

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((value) {
        Get.to(() => EmailVerificationScreen(
              email: email.text.trim(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(Get.overlayContext!);
      if (e.code == 'user-not-found') {
        MFLoader.errorSnackBar(title: "User not Found", message: "Username or password is incorrect");
      } else if (e.code == 'wrong-password') {
        MFLoader.errorSnackBar(title: "Wrong Password", message: "Username or passoword is incorrect.");
      } else if (e.code == 'invalid-email') {
        MFLoader.errorSnackBar(title: "Invalid email", message: "The email address is badly formatted");
      } else {
        MFLoader.errorSnackBar(title: "Error", message: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MFSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 150,
                    image: AssetImage(dark ? MFImages.darkAppLogo : MFImages.lightAppLogo),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Welcome Back !",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      TextButton(onPressed: () => Get.to(() => const AdminLoginScreen()), child: const Text("Admin")),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: MFSizes.spaceBtwSections,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      validator: (value) => MFValidator.validateEmail(value),
                      decoration: const InputDecoration(prefixIcon: Icon(Icons.email_outlined), labelText: "Email"),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields,
                    ),
                    Obx(
                      () => TextFormField(
                        controller: password,
                        validator: (value) => MFValidator.validatePassword(value),
                        obscureText: controller.hidePassword.value,
                        decoration: InputDecoration(
                          label: const Text("Password"),
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                            icon: Icon(controller.hidePassword.value ? EvaIcons.eye_off : EvaIcons.eye),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Row(
                        //   children: [
                        //     Checkbox(value: true, onChanged: (value) {}),
                        //     const Text("Remember me"),
                        //   ],
                        // ),
                        TextButton(
                          onPressed: () => Get.to(() => const ForgotPasswordScreen()),
                          child: Text(
                            "Forgot Password",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields / 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: login,
                        child: const Text("Log in"),
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwItems,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Get.to(() => const SignupScreen()),
                        child: const Text("Create Account"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
