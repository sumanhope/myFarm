import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/itemcontainer.dart';
import 'package:myfarm/data/repositories/authentication_repo.dart';
import 'package:myfarm/features/store/models/productmodal.dart';
import 'package:myfarm/features/store/screens/productdetails.dart';
import 'package:myfarm/features/store/screens/widget/gridlayout.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/popus/loader.dart';

class ProductRecommendScreen extends StatelessWidget {
  const ProductRecommendScreen({
    super.key,
  });

  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> productList = [];

    try {
      final snapshot = await FirebaseFirestore.instance.collection('products').get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        String title = data['Title'] ?? 'No title';
        String categoryId = doc.data()['CategoryId'] ?? 'Category ID Not Found';
        String id = doc.id;
        int stock = data['Stock'] ?? 0;
        String thumbnail = data['Thumbnail'];
        int price = data['Price'] ?? 0;
        String tag = data['Tag'] ?? '';

        productList.add(ProductModel(
          title: title,
          categoryId: categoryId,
          id: id,
          stock: stock,
          thumbnail: thumbnail,
          price: price,
          tag: tag,
        ));
      }
    } catch (e) {
      MFLoader.errorSnackBar(title: "Error", message: e.toString());
    }

    return productList;
  }

  Future<List<ProductModel>> getUserOrders(String userId) async {
    List<ProductModel> orderList = [];
    try {
      final snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).collection('Orders').get();
      for (var doc in snapshot.docs) {
        final data = doc.data();
        List<dynamic> items = data['items'] ?? [];

        for (var item in items) {
          String id = item['productId'];
          int stock = item['quantity'] ?? 0;
          String thumbnail = item['image'];
          int price = item['price'] ?? 0;
          String title = item['title'] ?? 'No title';
          String categoryId = item['categoryId'] ?? 'Category ID Not Found';
          String tag = item['tag'] ?? "";
          orderList.add(ProductModel(
            title: title,
            categoryId: categoryId,
            id: id,
            stock: stock,
            thumbnail: thumbnail,
            price: price,
            tag: tag,
          ));
        }
      }
    } catch (e) {
      MFLoader.errorSnackBar(title: "Error", message: e.toString());
    }
    return orderList;
  }

  double calculateDiceCoefficient(Set<String> userOrderTags, Set<String> productTags) {
    // Calculate intersection between user order tags and product tags
    Set<String> commonTags = userOrderTags.intersection(productTags);

    // Calculate Dice coefficient
    double diceCoefficient = (2 * commonTags.length) / (userOrderTags.length + productTags.length);

    return diceCoefficient;
  }

  Future<List<ProductModel>> getRecommendedProducts(String userId) async {
    List<ProductModel> productList = await getProducts();
    List<ProductModel> orderList = await getUserOrders(userId);
    List<ProductModel> recommendedProducts = [];
    double highestSimilarity = 0;
    productList.removeWhere((product) => orderList.any((order) => order.title == product.title));

    // Convert user order tags to a set of individual tags
    Set<String> userOrderTags = orderList.expand((order) => order.tag!.split(' ')).toSet();

    // Iterate over each product in the product list
    for (var product in productList) {
      // Convert product tags to a set
      Set<String> productTags = product.tag!.split(' ').map((tag) => tag.trim()).toSet();

      // Calculate Dice coefficient between the product's tags and the user's order tags
      double similarity = calculateDiceCoefficient(userOrderTags, productTags);
      print("$product : $similarity");
      // Check if similarity is above a threshold and if the product is not already in the order list
      if (similarity > highestSimilarity && !orderList.contains(product)) {
        recommendedProducts.add(product);
      }
    }

    return recommendedProducts;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MFAppBar(
        showBackArrow: true,
        title: Text("Recommended Products"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "All the products here are recommended based on your orders details. So please try this only after ordering some products.",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwSections,
              ),
              Flexible(
                child: FutureBuilder<List<ProductModel>>(
                  future: getRecommendedProducts(AuthenticationRepo.instance.authuser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<ProductModel>? productList = snapshot.data;
                      return MFGridLayout(
                        size: size,
                        itemcount: productList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ItemContainer(
                            size: size,
                            product: productList![index],
                            func: () => Get.to(
                              () => ProductDetailsScreen(
                                product: productList[index],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
