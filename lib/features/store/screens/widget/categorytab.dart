import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/itemcontainer.dart';
import 'package:myfarm/features/store/controllers/allproductcontrollers.dart';
import 'package:myfarm/features/store/screens/productdetails.dart';

import 'package:myfarm/features/store/screens/widget/gridlayout.dart';
import 'package:myfarm/utils/constants/sizes.dart';

class MFCategoryTab extends StatelessWidget {
  const MFCategoryTab({super.key, this.query});

  final Query? query;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(AllProductController());
    return Padding(
      padding: const EdgeInsets.all(MFSizes.defaultSpace),
      child: FutureBuilder(
        future: controller.fetchProductbyQuery(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Text Found"),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
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
    );
  }
}
