import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/circular_image.dart';
import 'package:myfarm/common/widgets/sectionheading.dart';
import 'package:myfarm/features/personalization/screens/editfullname.dart';
import 'package:myfarm/features/personalization/screens/editusername.dart';
import 'package:myfarm/utils/constants/image_strings.dart';
import 'package:myfarm/utils/constants/sizes.dart';

import '../controllers/usercontroller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.firstname, this.lastname, this.username, this.email, this.phonenumber});

  final String? firstname, lastname, username, email, phonenumber;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: MFAppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const CircularImage(
                      image: MFImages.darkAppLogo,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(onPressed: () {}, child: const Text("Change Profile Picture"))
                  ],
                ),
              ),
              const SizedBox(
                height: MFSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
              const SectionHeading(
                title: 'Profile Information',
                showButton: false,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
              ProfileMenu(
                title: 'Name',
                value: controller.user.value.fullname,
                func: () => Get.to(() => const EditFullnameScreen()),
              ),
              ProfileMenu(
                title: 'Username',
                value: controller.user.value.username,
                func: () => Get.to(() => const EditUsernameScreen()),
              ),
              const SizedBox(
                height: MFSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
              const SectionHeading(
                title: 'Personal Information',
                showButton: false,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
              ProfileMenu(
                title: 'User ID',
                value: controller.user.value.id,
                icon: CupertinoIcons.doc_on_clipboard,
                func: () {},
              ),
              ProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                func: () {},
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phonenumber,
                func: () {},
              ),
              const Divider(),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.icon = Icons.arrow_forward_ios_sharp,
    required this.func,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final VoidCallback func;
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MFSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Icon(
                icon,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
