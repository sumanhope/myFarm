import 'package:get/get.dart';
import 'package:myfarm/data/repositories/user/userrepo.dart';
import 'package:myfarm/features/authentication/models/usermodel.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userrepo = Get.put(UserRepo());

  @override
  void onInit() {
    super.onInit();

    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      final user = await userrepo.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }
  }
}
