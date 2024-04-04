import 'package:flutter/material.dart';
import 'package:myfarm/common/widgets/roundedcontainer.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class SucessScreen extends StatelessWidget {
  const SucessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.func,
  });

  final String title, subtitle;
  final VoidCallback func;
  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Column(
            children: [
              RoundedContainer(
                width: 250,
                height: 250,
                radius: 100,
                child: Icon(
                  Icons.task_alt_outlined,
                  color: dark ? Colors.black : MFColors.primary,
                  size: 180,
                ),
              ),
              const SizedBox(
                height: MFSizes.spaceBtwSections,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: MFSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: func,
                  child: const Text("Done"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
