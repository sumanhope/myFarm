import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/sectionheading.dart';
import 'package:myfarm/features/personalization/controllers/addresscontroller.dart';
import 'package:myfarm/utils/constants/sizes.dart';

class BillingddressSection extends StatelessWidget {
  const BillingddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    // final dark = MFHelperFunctions.isDarkMode(context);
    final controller = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: "Shipping Address",
          buttontitle: 'Change',
          func: () => controller.selectNewAddressPopup(context),
        ),
        controller.selectedAddress.value.id.isNotEmpty
            ? Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.selectedAddress.value.name, style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(
                      height: MFSizes.spaceBtwItems / 2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(
                          width: MFSizes.spaceBtwItems / 2,
                        ),
                        Text(controller.selectedAddress.value.phonenumber, style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwItems / 2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_history,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(
                          width: MFSizes.spaceBtwItems / 2,
                        ),
                        Text("${controller.selectedAddress.value.postal}, ${controller.selectedAddress.value.city}, ${controller.selectedAddress.value.country}",
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                  ],
                ),
              )
            : Text(
                "Please Select an Address before checking out.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ],
    );
  }
}
