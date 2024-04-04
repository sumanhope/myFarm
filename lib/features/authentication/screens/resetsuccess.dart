import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myfarm/features/authentication/screens/login.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class ResetSuccessScreen extends StatelessWidget {
  const ResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: Icon(
              CupertinoIcons.clear,
              color: dark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Column(
            children: [
              Icon(
                CupertinoIcons.mail_solid,
                color: dark ? Colors.white : MFColors.primary,
                size: 180,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwSections,
              ),
              Text(
                "Password Reset Link Sent",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
              Text(
                "We have send a password reset link in your email.",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text("Done"),
                ),
              ),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
