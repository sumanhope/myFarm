import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:myfarm/admin/admindashboard.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/roundedcontainer.dart';
import 'package:myfarm/features/store/models/productmodal.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';
import 'package:myfarm/utils/popus/loader.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.title;
    priceController.text = widget.product.price.toString();
    stockController.text = widget.product.stock.toString();
    tagController.text = widget.product.tag.toString();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const MFAppBar(
        showBackArrow: true,
        title: Text("Edit Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MFSizes.defaultSpace),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 350,
              padding: const EdgeInsets.all(MFSizes.productImageRadius * 2),
              decoration: BoxDecoration(
                color: dark ? MFColors.darkContainer : MFColors.lightContainer,
                image: DecorationImage(
                  image: NetworkImage(widget.product.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: MFSizes.spaceBtwSections,
            ),
            RoundedContainer(
              width: double.infinity,
              padding: const EdgeInsets.all(MFSizes.md),
              radius: 10,
              backgroundColor: dark ? MFColors.darkContainer : MFColors.primaryBackground,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.abc),
                    ),
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: stockController,
                    decoration: const InputDecoration(
                      labelText: "Stock ",
                      prefixIcon: Icon(Icons.numbers),
                    ),
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      labelText: "Price",
                      prefixIcon: Icon(Icons.money),
                    ),
                  ),
                  const SizedBox(
                    height: MFSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: tagController,
                    decoration: const InputDecoration(
                      labelText: "Tag",
                      prefixIcon: Icon(EvaIcons.pricetags_outline),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: MFSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      DocumentReference productRef = FirebaseFirestore.instance.collection('products').doc(widget.product.id);
                      await productRef.update(
                        {
                          'Title': nameController.text.trim(),
                          'Price': int.parse(priceController.text.trim()),
                          'Stock': int.parse(
                            stockController.text.trim(),
                          ),
                          'Tag': tagController.text.trim(),
                        },
                      ).then((value) {
                        MFLoader.sucessSnackBar(title: "Success", message: "Product has been changed");
                        Get.off(() => const AdminDashboardScreen());
                      });
                    } catch (e) {
                      MFLoader.warningSnackBar(title: "Error", message: e.toString());
                    }
                  },
                  child: const Text("Update")),
            )
          ],
        ),
      ),
    );
  }
}
