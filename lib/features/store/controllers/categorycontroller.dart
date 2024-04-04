import 'package:get/get.dart';
import 'package:myfarm/data/repositories/categoryrepo.dart';
import 'package:myfarm/features/store/models/categorymodel.dart';
import 'package:myfarm/utils/popus/loader.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final categoryrepo = Get.put(CategoryRepo());
  final RxList<CatergoryModel> allCategories = <CatergoryModel>[].obs;
  final RxList<CatergoryModel> featuredCategories = <CatergoryModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final categories = await categoryrepo.getAllCategories();

      allCategories.assignAll(categories);

      featuredCategories.assignAll(
        allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(5),
      );
    } catch (e) {
      MFLoader.errorSnackBar(title: "Error!", message: e.toString());
    }
  }
}
