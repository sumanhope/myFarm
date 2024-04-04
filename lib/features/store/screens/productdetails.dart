import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/favoriteicon.dart';
import 'package:myfarm/common/widgets/itemcontainer.dart';
import 'package:myfarm/common/widgets/roundedcontainer.dart';
import 'package:myfarm/common/widgets/sectionheading.dart';
import 'package:myfarm/features/store/controllers/allproductcontrollers.dart';
import 'package:myfarm/features/store/models/productmodal.dart';
import 'package:myfarm/features/store/screens/cart.dart';
import 'package:myfarm/features/store/screens/widget/gridlayout.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';
import 'package:myfarm/features/store/controllers/cartcontroller.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productcontroller = AllProductController.instance;
    final dark = MFHelperFunctions.isDarkMode(context);
    final size = MediaQuery.of(context).size;
    final controller = CartController.instance;
    controller.updateAlreadyAddedProdcutCount(product);
    return Scaffold(
      appBar: MFAppBar(
        showBackArrow: true,
        title: Text(
          "Product Details",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          FavoriteIcon(
            productId: product.id,
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MFSizes.defaultSpace),
        child: Obx(
          () => ElevatedButton(
            onPressed: controller.productQuantityInCart.value < 1 ? null : () => controller.addToCart(product),
            child: const Text("Add to cart"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 350,
              padding: const EdgeInsets.all(MFSizes.productImageRadius * 2),
              decoration: BoxDecoration(
                color: dark ? MFColors.darkContainer : MFColors.lightContainer,
                image: DecorationImage(
                  image: NetworkImage(product.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: MFSizes.spaceBtwItems / 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoundedContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.all(MFSizes.sm),
                    radius: 10,
                    backgroundColor: dark ? MFColors.darkContainer : MFColors.primaryBackground,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: MFSizes.sm,
                        ),
                        Text(
                          "Tags: ${product.tag}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: MFSizes.sm,
                        ),
                        Text(
                          "Stock: ${product.stock}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rs. ${product.price}",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwItems,
                  ),
                  RoundedContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.all(MFSizes.md),
                    radius: 10,
                    backgroundColor: dark ? MFColors.darkContainer : MFColors.primaryBackground,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Obx(
                          () => ProductAddRemove(
                            quantity: controller.productQuantityInCart.value,
                            remove: () => controller.productQuantityInCart.value < 1 ? null : controller.productQuantityInCart.value -= 1,
                            add: () => controller.productQuantityInCart.value += 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwItems,
                  ),
                  RoundedContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.all(MFSizes.md),
                    radius: 10,
                    backgroundColor: dark ? MFColors.darkContainer : MFColors.primaryBackground,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: MFSizes.spaceBtwItems / 2,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.verified),
                            const SizedBox(
                              width: MFSizes.spaceBtwItems,
                            ),
                            Column(
                              children: [
                                Text(
                                  "100% Authentic Brands",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  "or Get 2x Your Money Back",
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: MFSizes.spaceBtwItems / 2,
                        ),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.return_icon),
                            const SizedBox(
                              width: MFSizes.spaceBtwItems,
                            ),
                            Column(
                              children: [
                                Text(
                                  "10 days free & easy return",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  "change of mind is not applicable",
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwItems,
                  ),
                  const SectionHeading(
                    title: "You might also like:",
                    showButton: false,
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwItems / 2,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: FutureBuilder<List<ProductModel>>(
                      future: productcontroller.fetchProductbyQuery(
                        FirebaseFirestore.instance.collection('products').where('CategoryId', isEqualTo: product.categoryId).where('Title', isNotEqualTo: product.title),
                      ),
                      builder: (context, snapshots) {
                        if (snapshots.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshots.hasError) {
                          return const Center(
                            child: Text(
                              "Error",
                              textAlign: TextAlign.justify,
                            ),
                          );
                        }

                        final products = snapshots.data!;
                        //print(products.length);
                        if (products.isEmpty) {
                          return const Center(
                            child: Text("No similar Product"),
                          );
                        } else {
                          return MFGridLayout(
                            size: size,
                            itemcount: 2,
                            itemBuilder: (_, index) {
                              return ItemContainer(
                                  size: size,
                                  product: products[index],
                                  func: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailsScreen(product: products[index]);
                                      },
                                    ));
                                  });
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
