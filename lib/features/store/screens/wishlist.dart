//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/itemcontainer.dart';
import 'package:myfarm/features/personalization/controllers/favcontroller.dart';
import 'package:myfarm/features/store/screens/productdetails.dart';
import 'package:myfarm/features/store/screens/widget/gridlayout.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/cloud_helper_functions.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final dark = MFHelperFunctions.isDarkMode(context);
    final controller = Get.put(FavoriteController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MFAppBar(
        showBackArrow: false,
        title: Text(
          'WishList',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: const [
          // IconButton(
          //   onPressed: () => Get.to(() => const HomeScreen()),
          //   icon: Icon(
          //     CupertinoIcons.add,
          //     color: dark ? Colors.white : Colors.black,
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              future: controller.favProducts(),
              builder: (context, snapshot) {
                final response = MFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if (response != null) return response;
                final products = snapshot.data!;

                return MFGridLayout(
                  size: size,
                  itemcount: products.length,
                  itemBuilder: (_, index) {
                    return ItemContainer(
                      size: size,
                      product: products[index],
                      func: () => Get.to(
                        () => ProductDetailsScreen(
                          product: products[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
