import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/features/personalization/controllers/addresscontroller.dart';
import 'package:myfarm/features/personalization/screens/addnewaddress.dart';
import 'package:myfarm/features/personalization/screens/widgets/singleaddress.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/cloud_helper_functions.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MFColors.primary,
        onPressed: () => Get.to(
          () => const NewAddressScreen(),
        ),
        child: const Icon(
          CupertinoIcons.add,
          color: MFColors.white,
        ),
      ),
      appBar: MFAppBar(
        showBackArrow: true,
        title: Text(
          "My Address",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MFSizes.defaultSpace),
            child: Obx(
              () => FutureBuilder(
                key: Key(controller.refreshData.value.toString()),
                future: controller.allUserAddresses(),
                builder: (context, snapshot) {
                  final response = MFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                  if (response != null) return response;
                  final address = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: address.length,
                    itemBuilder: (_, index) => SingleAddress(
                      address: address[index],
                      onTap: () => controller.selectAddress(address[index]),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
