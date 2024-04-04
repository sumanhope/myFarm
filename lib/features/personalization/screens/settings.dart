import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/circular_image.dart';
import 'package:myfarm/common/widgets/sectionheading.dart';
import 'package:myfarm/features/authentication/screens/login.dart';
import 'package:myfarm/features/personalization/controllers/usercontroller.dart';
import 'package:myfarm/features/personalization/screens/address.dart';
import 'package:myfarm/features/personalization/screens/productrecommend.dart';
import 'package:myfarm/features/personalization/screens/profile.dart';
import 'package:myfarm/features/personalization/screens/widgets/setting_menu_tile.dart';
import 'package:myfarm/features/store/screens/cart.dart';
import 'package:myfarm/features/store/screens/order.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/image_strings.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool dark = MFHelperFunctions.isDarkMode(context);
    final controller = UserController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: MultipleRoundedCurveClipper(),
              child: Container(
                color: dark ? MFColors.darkContainer : Colors.green,
                child: Column(
                  children: [
                    MFAppBar(
                      showBackArrow: false,
                      title: Text(
                        "Account",
                        style: Theme.of(context).textTheme.headlineMedium!.apply(color: MFColors.white),
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwItems,
                    ),
                    ProfileUserTile(
                      name: controller.user.value.fullname,
                      email: controller.user.value.email,
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwSections,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(MFSizes.defaultSpace),
              child: Column(
                children: [
                  const SectionHeading(
                    title: 'Account Settings',
                    showButton: false,
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwItems,
                  ),
                  MFSettingTile(
                    icon: CupertinoIcons.home,
                    title: "My Address",
                    subtitle: "Set delivery address",
                    onTap: () => Get.to(() => const AddressScreen()),
                  ),
                  MFSettingTile(
                    icon: CupertinoIcons.cart,
                    title: "My Cart",
                    subtitle: "Add, remove products and checkout",
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  MFSettingTile(
                    icon: CupertinoIcons.bag_badge_plus,
                    title: "My Orders",
                    subtitle: "In-progress and complete orders",
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  MFSettingTile(
                    icon: Icons.recommend_outlined,
                    title: "Product Recommendation",
                    subtitle: "Get all the recommended products ",
                    onTap: () => Get.to(() => const ProductRecommendScreen()),
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwSections,
                  ),
                  const SectionHeading(
                    title: 'App Settings',
                    showButton: false,
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwItems,
                  ),
                  MFSettingTile(
                    icon: CupertinoIcons.moon,
                    title: "Dark Mode",
                    subtitle: "Switch to Dark or Light mode",
                    trailing: Switch(
                      value: dark,
                      onChanged: (value) {
                        setState(() {
                          dark = value;
                        });
                        Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                      },
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: MFSizes.spaceBtwItems,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) => Get.offAll(() => const LoginScreen()));
                      },
                      child: const Text("Log out"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileUserTile extends StatelessWidget {
  const ProfileUserTile({
    super.key,
    required this.name,
    required this.email,
  });
  final String name, email;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircularImage(
        image: MFImages.lightAppLogo,
        width: 56,
        height: 56,
        fit: BoxFit.fill,
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: MFColors.white),
      ),
      subtitle: Text(
        email,
        style: Theme.of(context).textTheme.bodyMedium!.apply(color: MFColors.white),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: const Icon(
          Icons.edit_square,
          color: Colors.white,
        ),
      ),
    );
  }
}
