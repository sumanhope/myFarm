import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/data/repositories/authentication_repo.dart';
import 'package:myfarm/features/personalization/controllers/usercontroller.dart';
import 'package:myfarm/main.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/popus/loader.dart';

class EditUsernameScreen extends StatelessWidget {
  const EditUsernameScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final usernameController = TextEditingController();
    return Scaffold(
      appBar: const MFAppBar(
        showBackArrow: true,
        title: Text("Edit Username"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MFSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter new username in below text field",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: MFSizes.spaceBtwItems,
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: controller.user.value.username,
              ),
            ),
            const SizedBox(
              height: MFSizes.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(AuthenticationRepo.instance.authuser?.uid);
                    await userRef.update({'Username': usernameController.text.trim()}).then(
                      (value) {
                        MFLoader.sucessSnackBar(title: "Success", message: "Username has been changed");
                        controller.fetchUserRecord();
                        Get.to(() => const LandingPage());
                      },
                    );
                  } catch (e) {
                    MFLoader.errorSnackBar(
                      title: "Error",
                      message: e.toString(),
                    );
                  }
                },
                child: const Text("Update"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
