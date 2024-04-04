import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:myfarm/features/authentication/controllers/signup/signupcontroller.dart';
import 'package:myfarm/features/authentication/screens/login.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';
import 'package:myfarm/utils/validators/validation.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.offAll(() => const LoginScreen()),
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: dark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create your Account.",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwSections,
              ),
              Form(
                key: controller.signupFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstname,
                            validator: (value) => MFValidator.validateEmptyText('First name', value),
                            expands: false,
                            decoration: const InputDecoration(
                              label: Text("First Name"),
                              prefixIcon: Icon(EvaIcons.person),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: MFSizes.spaceBtwItems,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: controller.lastname,
                            validator: (value) => MFValidator.validateEmptyText('Last name', value),
                            expands: false,
                            decoration: const InputDecoration(
                              label: Text("Last Name"),
                              prefixIcon: Icon(EvaIcons.person),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      validator: (value) => MFValidator.validateEmptyText('Username', value),
                      controller: controller.username,
                      decoration: const InputDecoration(
                        label: Text("Username"),
                        prefixIcon: Icon(Icons.abc),
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: controller.email,
                      validator: (value) => MFValidator.validateEmail(value),
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: controller.phonenumber,
                      validator: (value) => MFValidator.validatePhoneNumber(value),
                      decoration: const InputDecoration(
                        label: Text("Phone Number"),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields,
                    ),
                    Obx(
                      () => TextFormField(
                        controller: controller.password,
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
                      height: MFSizes.spaceBtwSections,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Obx(
                            () => Checkbox(
                              value: controller.privacypolicy.value,
                              onChanged: (value) => controller.privacypolicy.value = !controller.privacypolicy.value,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: MFSizes.spaceBtwItems,
                        ),
                        Text(
                          "I agree to Privacy Policy and Terms of use.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwSections,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(child: const Text("Create Account"), onPressed: () => controller.signup()),
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
