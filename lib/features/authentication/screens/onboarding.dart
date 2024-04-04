import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:myfarm/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/image_strings.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/device/device_utility.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: MFImages.onBoardingImage1,
                title: "Find your Product!",
                subtitle: "Here you can find all the things needed for your farm. - Home of Farming stuffs",
              ),
              OnBoardingPage(
                image: MFImages.onBoardingImage2,
                title: "No card needed",
                subtitle: "Scared of online scams? No worries we accept cash.",
              ),
              OnBoardingPage(
                image: MFImages.onBoardingImage3,
                title: "Deliver at your door step",
                subtitle: "From our Doorstep to yours - Swift and Secure",
              )
            ],
          ),
          Positioned(
            top: MFDeviceUtils.getAppBarHeight(),
            right: MFSizes.defaultSpace,
            child: TextButton(
              onPressed: () => OnBoardingController.instance.skipPage(),
              child: const Text("Skip"),
            ),
          ),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Positioned(
      right: MFSizes.defaultSpace,
      bottom: MFDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: dark ? MFColors.primary : Colors.black),
        child: const Icon(
          EvaIcons.arrow_ios_forward_outline,
          size: 30,
        ),
      ),
    );
  }
}

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = MFHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: MFDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: MFSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(activeDotColor: dark ? MFColors.light : MFColors.dark, dotHeight: 6),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MFSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: MFHelperFunctions.screenWidth() * 0.8,
            height: MFHelperFunctions.screenHeight() * 0.6,
            image: AssetImage(image),
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
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
