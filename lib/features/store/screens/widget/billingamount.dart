import 'package:flutter/material.dart';
import 'package:myfarm/features/store/controllers/cartcontroller.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/pricing_calculator.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subtotal = controller.totalCartPrice.value;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Rs. $subtotal',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(height: MFSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping Fee:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Rs. ${TPricingCalculator.calculateShippingCost(subtotal * 1.0, 'NP')}',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        const SizedBox(height: MFSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tax Fee:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Rs. ${TPricingCalculator.calculateTax(subtotal * 1.0, 'NP')}',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        const SizedBox(height: MFSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Total:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Rs. ${TPricingCalculator.calculateTotalPrice(subtotal * 1.0, 'NP')}',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ],
    );
  }
}
