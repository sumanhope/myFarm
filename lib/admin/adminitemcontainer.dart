import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/admin/editproduct.dart';

import 'package:myfarm/features/store/models/productmodal.dart';

import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class AdminItemContainer extends StatelessWidget {
  const AdminItemContainer({
    super.key,
    required this.size,
    required this.product,
  });

  final Size size;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => EditProductScreen(product: product)),
      child: Container(
        width: size.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: dark ? MFColors.darkContainer : Colors.lightGreen[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.18,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: NetworkImage(product.thumbnail), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(MFSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "In Stock: ${product.stock}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: MFSizes.sm / 5,
                  ),
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: MFSizes.sm / 2,
                  ),
                  Text(
                    "Rs.${product.price}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
