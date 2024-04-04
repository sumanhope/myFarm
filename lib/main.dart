import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfarm/bindings/generalbindings.dart';
import 'package:myfarm/data/repositories/authentication_repo.dart';
import 'package:myfarm/features/personalization/screens/settings.dart';
import 'package:myfarm/firebase_options.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';
import 'package:myfarm/utils/local_storage/storage_utility.dart';
import 'package:myfarm/utils/theme/theme.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'features/store/screens/home.dart';
import 'features/store/screens/store.dart';
import 'features/store/screens/wishlist.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await MFLocalStorage.init('favorites');
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepo()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyFarm',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MFAppTheme.lightTheme,
      darkTheme: MFAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: const Scaffold(
        backgroundColor: MFColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> pages = [
    const HomeScreen(),
    const StoreScreen(),
    const WishListScreen(),
    const SettingScreen(),
  ];

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: pages[currentStep],
        bottomNavigationBar: Container(
          color: dark ? Colors.black : MFColors.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: GNav(
              hoverColor: Colors.white10,
              backgroundColor: dark ? Colors.black : MFColors.primary,
              color: const Color.fromARGB(218, 224, 224, 224),
              activeColor: dark ? Colors.black : Colors.white,
              tabBackgroundColor: dark ? const Color.fromRGBO(129, 199, 132, 1) : const Color.fromRGBO(66, 160, 71, 1),
              gap: 6,
              padding: const EdgeInsets.all(10),
              iconSize: 25,
              textStyle: TextStyle(
                fontSize: 15,
                color: dark ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                GButton(
                  icon: currentStep == 0 ? EvaIcons.home : EvaIcons.home_outline,
                  text: "Home",
                ),
                GButton(
                  icon: currentStep == 1 ? Icons.storefront_rounded : Icons.storefront_outlined,
                  text: "Store",
                ),
                GButton(
                  icon: currentStep == 2 ? EvaIcons.heart : EvaIcons.heart_outline,
                  text: "Wishlist",
                ),
                GButton(
                  icon: currentStep == 3 ? EvaIcons.person : EvaIcons.person_outline,
                  text: "Profile",
                ),
              ],
              selectedIndex: currentStep,
              onTabChange: (index) {
                setState(() {
                  currentStep = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
