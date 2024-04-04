import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/itemcontainer.dart';
import 'package:myfarm/common/widgets/sectionheading.dart';
import 'package:myfarm/features/store/controllers/categorycontroller.dart';
import 'package:myfarm/features/store/controllers/productcontroller.dart';
import 'package:myfarm/features/store/screens/allproduct.dart';
import 'package:myfarm/features/store/screens/productdetails.dart';
import 'package:myfarm/features/store/screens/search.dart';
import 'package:myfarm/features/store/screens/widget/gridlayout.dart';
import 'package:myfarm/features/store/screens/widget/homeappbar.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/device/device_utility.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    final size = MediaQuery.of(context).size;
    final controller = Get.put(ProductController());
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
                    const HomeAppBar(),
                    const SizedBox(
                      height: MFSizes.spaceBtwSections,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: MFSizes.defaultSpace),
                      child: GestureDetector(
                        onTap: () => Get.to(() => const SearchPage()),
                        child: Container(
                          width: MFDeviceUtils.getScreenWidth(context),
                          padding: const EdgeInsets.all(MFSizes.md),
                          decoration: BoxDecoration(
                            color: dark ? Colors.transparent : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: MFColors.white),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.search,
                                color: dark ? Colors.white : MFColors.darkerGrey,
                              ),
                              const SizedBox(
                                width: MFSizes.spaceBtwItems,
                              ),
                              Text(
                                "Search in Store",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwSections,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: MFSizes.defaultSpace),
                      child: Column(
                        children: [
                          SectionHeading(
                            title: 'Popular Categories',
                            showButton: false,
                            textColor: Colors.white,
                          ),
                          SizedBox(
                            height: MFSizes.spaceBtwItems,
                          ),
                          HomeCategories()
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwSections,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: MFSizes.md,
                right: MFSizes.md,
              ),
              child: Column(
                children: [
                  SectionHeading(
                    title: "Popular Products",
                    showButton: true,
                    func: () => Get.to(() => AllProductScreens(
                          title: "Popular Products",
                          query: FirebaseFirestore.instance.collection('products').where('IsFeatured', isEqualTo: true),
                        )),
                    textColor: dark ? Colors.white : Colors.black,
                  ),
                  Obx(
                    () {
                      return MFGridLayout(
                        size: size,
                        itemcount: controller.featureProducts.length,
                        itemBuilder: (_, index) {
                          return ItemContainer(
                            size: size,
                            product: controller.featureProducts[index],
                            func: () => Get.to(
                              () => ProductDetailsScreen(
                                product: controller.featureProducts[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: MFSizes.sm,
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

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      return SizedBox(
        height: 90,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return Padding(
              padding: const EdgeInsets.only(right: MFSizes.spaceBtwItems),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => AllProductScreens(
                          title: category.name,
                          query: FirebaseFirestore.instance.collection('products').where('CategoryId', isEqualTo: category.name),
                        )),
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(MFSizes.sm),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Icon(
                          (category.name == "Seeds")
                              ? Icons.grass
                              : (category.name == "Tools")
                                  ? Icons.handyman
                                  : (category.name == "Foods")
                                      ? Icons.local_grocery_store
                                      : (category.name == "Plants")
                                          ? CupertinoIcons.tree
                                          : (category.name == "Fertilizers")
                                              ? Icons.compost
                                              : Icons.flourescent,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwItems / 2,
                  ),
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.white),
                  )
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
