import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfarm/admin/adminitemcontainer.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/features/store/controllers/allproductcontrollers.dart';
import 'package:myfarm/features/store/models/productmodal.dart';
import 'package:myfarm/features/store/screens/widget/gridlayout.dart';
import 'package:myfarm/utils/constants/sizes.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({super.key});

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  final controller = AllProductController.instance;

  String productname = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MFAppBar(
        showBackArrow: true,
        title: Text("Search Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                  ),
                  hintText: 'Search',
                ),
                onChanged: (value) {
                  setState(
                    () {
                      productname = value.toLowerCase();
                    },
                  );
                },
              ),
              const SizedBox(
                height: MFSizes.spaceBtwSections,
              ),
              Flexible(
                child: FutureBuilder<List<ProductModel>>(
                  future: controller.fetchAllProducts(),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshots.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshots.error}",
                          textAlign: TextAlign.justify,
                        ),
                      );
                    }
                    final products = snapshots.data!;
                    final filteredProducts = products.where((product) => product.title.toLowerCase().contains(productname));
                    if (filteredProducts.isEmpty) {
                      return const Center(
                        child: Text(
                          "No similar product found",
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }

                    return MFGridLayout(
                      size: size,
                      itemcount: products.length,
                      itemBuilder: (_, index) {
                        if (index < filteredProducts.length) {
                          return AdminItemContainer(
                            size: size,
                            product: filteredProducts.elementAt(index),
                          );
                        }
                        return const SizedBox();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
