import 'package:flutter/material.dart';
import 'package:myfarm/common/widgets/roundedcontainer.dart';
import 'package:myfarm/common/widgets/sectionheading.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);

    return Column(children: [
      SectionHeading(
        title: "Payment Method",
        buttontitle: 'Change',
        func: () {},
      ),
      const SizedBox(
        height: MFSizes.spaceBtwItems / 2,
      ),
      Row(
        children: [
          RoundedContainer(
            padding: const EdgeInsets.all(MFSizes.sm),
            backgroundColor: dark ? MFColors.light : MFColors.white,
            child: const Icon(
              Icons.money,
              size: 30,
              color: MFColors.dark,
            ),
          ),
          const SizedBox(width: MFSizes.spaceBtwItems / 2),
          Text("Cash on Delivery", style: Theme.of(context).textTheme.bodyLarge),
        ],
      )
    ]);
  }
}
