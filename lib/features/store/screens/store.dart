import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/carticon.dart';
import 'package:myfarm/common/widgets/tabbar.dart';
import 'package:myfarm/features/store/controllers/categorycontroller.dart';
import 'package:myfarm/features/store/screens/search.dart';
import 'package:myfarm/features/store/screens/widget/categorytab.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/device/device_utility.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    final dark = MFHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: MFAppBar(
          showBackArrow: false,
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: const [
            CartCounterItem(),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, boxscroll) {
            return [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: dark ? MFColors.black : MFColors.white,
                  expandedHeight: 150,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(MFSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() => const SearchPage()),
                          child: Container(
                            width: MFDeviceUtils.getScreenWidth(context),
                            padding: const EdgeInsets.all(MFSizes.md),
                            decoration: BoxDecoration(
                              color: dark ? Colors.transparent : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 2, color: MFColors.accent),
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
                      ],
                    ),
                  ),
                  bottom: MFTabBar(
                      tabs: categories
                          .map(
                            (category) => Tab(
                              child: Text(category.name),
                            ),
                          )
                          .toList()))
            ];
          },
          body: TabBarView(
              children: categories
                  .map((element) => MFCategoryTab(
                        query: FirebaseFirestore.instance.collection('products').where('CategoryId', isEqualTo: element.name),
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
