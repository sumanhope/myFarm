import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/roundedcontainer.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/features/store/controllers/cartcontroller.dart';
import 'package:myfarm/features/store/controllers/ordercontroller.dart';
import 'package:myfarm/features/store/screens/cart.dart';
import 'package:myfarm/features/store/screens/widget/billingaddress.dart';
import 'package:myfarm/features/store/screens/widget/billingamount.dart';
import 'package:myfarm/features/store/screens/widget/billingpayment.dart';

import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';
import 'package:myfarm/utils/helpers/pricing_calculator.dart';
import 'package:myfarm/utils/popus/loader.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    final cartcontroller = CartController.instance;
    final subtotal = cartcontroller.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subtotal * 1.0, 'NP');
    return Scaffold(
      appBar: MFAppBar(
        showBackArrow: true,
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MFSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subtotal > 0 ? () => orderController.processOrder(totalAmount) : () => MFLoader.warningSnackBar(title: "Empty Cart", message: "Add items in the cart to order."),
          child: Text("Checkout Rs.${TPricingCalculator.calculateTotalPrice(subtotal * 1.0, 'NP')} "),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Column(
            children: [
              const AllCartItem(
                showAddandRemovebuttons: false,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwSections,
              ),
              RoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(MFSizes.md),
                backgroundColor: dark ? MFColors.darkContainer : MFColors.lightContainer,
                child: const Column(
                  children: [
                    BillingAmountSection(),
                    SizedBox(
                      height: MFSizes.spaceBtwItems,
                    ),
                    Divider(),
                    BillingPaymentSection(),
                    SizedBox(
                      height: MFSizes.spaceBtwItems,
                    ),
                    Divider(),
                    SizedBox(
                      height: MFSizes.spaceBtwItems,
                    ),
                    BillingddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
