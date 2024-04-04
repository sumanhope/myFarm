import 'package:cloud_firestore/cloud_firestore.dart';

class CatergoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CatergoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = "",
  });

  static CatergoryModel empty() => CatergoryModel(id: "", name: '', image: '', isFeatured: false);

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  factory CatergoryModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CatergoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? '',
      );
    }
    return CatergoryModel.empty();
  }
}
