import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/features/personalization/controllers/addresscontroller.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/validators/validation.dart';

class NewAddressScreen extends StatelessWidget {
  const NewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: MFAppBar(
        showBackArrow: true,
        title: Text(
          'Add new Address',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) => MFValidator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                    label: Text("Name"),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: MFSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => MFValidator.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                    label: Text("Phone Number"),
                    prefixIcon: Icon(Icons.numbers),
                  ),
                ),
                const SizedBox(
                  height: MFSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        expands: false,
                        controller: controller.city,
                        validator: (value) => MFValidator.validateEmptyText('City', value),
                        decoration: const InputDecoration(
                          label: Text("City"),
                          prefixIcon: Icon(Icons.place),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: MFSizes.spaceBtwItems,
                    ),
                    Expanded(
                      child: TextFormField(
                        expands: false,
                        controller: controller.postal,
                        validator: (value) => MFValidator.validateEmptyText('Postal', value),
                        decoration: const InputDecoration(
                          label: Text("Postal"),
                          prefixIcon: Icon(Icons.code),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: MFSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: controller.country,
                  validator: (value) => MFValidator.validateEmptyText('Country', value),
                  decoration: const InputDecoration(
                    label: Text("Country"),
                    prefixIcon: Icon(CupertinoIcons.globe),
                  ),
                ),
                const SizedBox(
                  height: MFSizes.defaultSpace,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewAddress(),
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
