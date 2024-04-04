import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/sectionheading.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';
import 'package:myfarm/utils/popus/loader.dart';
import 'package:myfarm/utils/validators/validation.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final title = TextEditingController();
  final stock = TextEditingController();
  final price = TextEditingController();
  final tag = TextEditingController();
  String imageUrl = "";

  File? _image;

  String dropdownvalue = 'Seeds';

  var items = ['Seeds', 'Tools', 'Foods', 'Plants', 'Fertilizers'];

  Future submitProduct() async {
    try {
      FirebaseFirestore.instance.collection('products').doc().set({
        'Title': title.text.trim(),
        'Stock': int.parse(stock.text.trim()),
        'Price': int.parse(price.text.trim()),
        'IsFeatured': false,
        'CategoryId': dropdownvalue,
        'Thumbnail': imageUrl,
        'Tag': tag.text.trim(),
      }).then(
        (value) {
          title.clear();
          stock.clear();
          price.clear();
          tag.clear();
          imageUrl = "";
          MFLoader.sucessSnackBar(title: "Product Added", message: "Your product has been added.");
        },
      );
    } on Exception catch (e) {
      Navigator.pop(context);
      debugPrint(e.toString());
    }
  }

  void choosePhoto() async {
    // choosing image

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    debugPrint(image?.path);
    if (image == null) return;
    File? img = File(image.path);
    //img = await cropimage(img);
    setState(() {
      _image = img;
    });
    String uniqueFilename = UniqueKey().toString();
    // uploading image to Storage
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirIamges = referenceRoot.child('products');
    Reference referenceImagetoUpload = referenceDirIamges.child(uniqueFilename);
    try {
      showDialog(
          context: Get.overlayContext!,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          });
      await referenceImagetoUpload.putFile(_image!).then((p0) {
        Navigator.of(context).pop();
        MFLoader.currentToast(message: "Photo Uploaded");
      });

      imageUrl = await referenceImagetoUpload.getDownloadURL();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    //addProfile(imageUrl);
    setState(() {});
  }

  // Future<File?> cropimage(File imagefile) async {
  //   CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imagefile.path, cropStyle: CropStyle.circle);
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }

  // Future addProfile(String link) async {
  //   final usercollection = FirebaseFirestore.instance.collection('users');
  //   final docRef = usercollection.doc(_uid);

  //   try {
  //     docRef.update({"profile": link});
  //   } on Exception catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const MFAppBar(
        showBackArrow: true,
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: dark ? MFColors.darkContainer : MFColors.lightContainer,
                child: imageUrl == ""
                    ? const Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 100,
                        ),
                      )
                    : Image(image: NetworkImage(imageUrl)),
              ),
              TextButton(
                onPressed: choosePhoto,
                child: Text(
                  "Choose Photo",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SectionHeading(
                title: "Product Fields",
                showButton: false,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) => MFValidator.validateEmptyText('Username', value),
                      controller: title,
                      decoration: const InputDecoration(
                        label: Text("Item Name"),
                        prefixIcon: Icon(Icons.abc),
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: stock,
                            validator: (value) => MFValidator.validateEmptyText('First name', value),
                            expands: false,
                            decoration: const InputDecoration(
                              label: Text("Total Stock"),
                              prefixIcon: Icon(Icons.numbers),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: MFSizes.spaceBtwItems,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: price,
                            validator: (value) => MFValidator.validateEmptyText('Last name', value),
                            expands: false,
                            decoration: const InputDecoration(
                              label: Text("Price"),
                              prefixIcon: Icon(EvaIcons.pricetags),
                            ),
                          ),
                        )
                      ],
                    ),

                    // TextFormField(
                    //   validator: (value) => MFValidator.validateEmptyText('Username', value),
                    //   controller: category,
                    //   decoration: const InputDecoration(
                    //     label: Text("Category"),
                    //     prefixIcon: Icon(Icons.account_tree),
                    //   ),
                    // ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      validator: (value) => MFValidator.validateEmptyText('Tag', value),
                      controller: tag,
                      decoration: const InputDecoration(
                        label: Text("Tags"),
                        prefixIcon: Icon(Icons.abc),
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(width: 3, color: dark ? MFColors.borderPrimary : MFColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(
                        padding: const EdgeInsets.all(MFSizes.sm),
                        dropdownColor: MFColors.accent,
                        underline: Container(),
                        isExpanded: true,
                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwInputFields,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: submitProduct, child: const Text("Submit")),
                    ),
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
