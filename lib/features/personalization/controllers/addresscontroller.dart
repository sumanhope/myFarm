import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/sectionheading.dart';
import 'package:myfarm/data/repositories/addressrepo.dart';
import 'package:myfarm/features/personalization/models/addressmodal.dart';
import 'package:myfarm/features/personalization/screens/addnewaddress.dart';
import 'package:myfarm/features/personalization/screens/widgets/singleaddress.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/cloud_helper_functions.dart';
import 'package:myfarm/utils/popus/loader.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepo = Get.put(AddressRepo());

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final city = TextEditingController();
  final postal = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;

  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepo.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      MFLoader.errorSnackBar(title: "Address not found", message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepo.updateSelectedField(selectedAddress.value.id, false);
      }
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await addressRepo.updateSelectedField(selectedAddress.value.id, true);
    } catch (e) {
      throw e.toString();
    }
  }

  Future addNewAddress() async {
    try {
      final address = AddressModel(
        id: "",
        name: name.text.trim(),
        phonenumber: phoneNumber.text.trim(),
        city: city.text.trim(),
        postal: postal.text.trim(),
        country: country.text.trim(),
      );
      final id = await addressRepo.addAddress(address);

      address.id = id;
      await (selectAddress(address));

      MFLoader.sucessSnackBar(title: "Sucess", message: "Address has been added");
      refreshData.toggle();

      resetFormFields();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(MFSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeading(
                    title: 'Select Address',
                    showButton: false,
                  ),
                  FutureBuilder(
                    future: allUserAddresses(),
                    builder: (_, snapshot) {
                      final response = MFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                      if (response != null) return response;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          return SingleAddress(
                            address: snapshot.data![index],
                            onTap: () async {
                              selectedAddress(snapshot.data![index]);
                              Get.back();
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: MFSizes.defaultSpace,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const NewAddressScreen()),
                      child: const Text("Add Address"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    city.clear();
    country.clear();
    postal.clear();
  }
}
