import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfarm/features/personalization/controllers/addresscontroller.dart';
import 'package:myfarm/features/personalization/models/addressmodal.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  // final bool selectedAddress;
  final AddressModel address;

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    final controller = AddressController.instance;

    final selectedAddressId = controller.selectedAddress.value.id;
    final selectedAddress = selectedAddressId == address.id;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(MFSizes.sm),
        margin: const EdgeInsets.only(bottom: MFSizes.spaceBtwItems),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.green),
          color: selectedAddress ? MFColors.primary.withOpacity(0.5) : Colors.transparent,
        ),
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              child: Icon(
                selectedAddress ? CupertinoIcons.checkmark_circle_fill : null,
                color: selectedAddress
                    ? dark
                        ? MFColors.light
                        : MFColors.dark
                    : null,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: MFSizes.sm,
                ),
                Text(
                  address.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: MFSizes.sm / 2,
                ),
                Text(
                  address.phonenumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: MFSizes.sm / 2,
                ),
                Text(
                  '${address.postal} ${address.city}, ${address.country}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: MFSizes.sm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
