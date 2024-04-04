import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/admin/addproduct.dart';
import 'package:myfarm/admin/viewproduct.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/roundedcontainer.dart';
import 'package:myfarm/features/authentication/screens/login.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Do you want Log out?',
                textAlign: TextAlign.center,
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) => Get.offAll(() => const LoginScreen()));
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: const MFAppBar(
          showBackArrow: false,
          title: Text("Admin Dashboard"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdminOptions(
                      func: () => Get.to(() => const AddProductScreen()),
                      icon: Icons.add_outlined,
                      title: "Add Product",
                    ),
                    AdminOptions(
                      func: () => Get.to(() => const ViewProductScreen()),
                      icon: Icons.view_agenda_outlined,
                      title: "View Product",
                    ),
                  ],
                ),
                const SizedBox(
                  height: MFSizes.spaceBtwItems,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminOptions extends StatelessWidget {
  const AdminOptions({
    super.key,
    required this.func,
    required this.icon,
    required this.title,
  });

  final VoidCallback func;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: RoundedContainer(
        radius: 10,
        width: 180,
        height: 170,
        padding: const EdgeInsets.all(MFSizes.defaultSpace),
        showBorder: true,
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: MFColors.accent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                size: 40,
              ),
            ),
            const SizedBox(
              height: MFSizes.defaultSpace,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
