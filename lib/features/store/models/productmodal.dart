import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  int stock;
  int price;
  String title;
  String thumbnail;
  bool? isFeatured;
  String? description;
  String categoryId;
  String? tag;
  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.thumbnail,
    required this.categoryId,
    this.description,
    this.isFeatured,
    required this.price,
    this.tag,
  });

  static ProductModel empty() => ProductModel(id: "", title: "", stock: 0, thumbnail: "", price: 0, categoryId: "");

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      title: data['Title'],
      stock: data['Stock'] ?? 0,
      thumbnail: data['Thumbnail'] ?? '',
      price: data['Price'] ?? 0,
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      tag: data["Tag"] ?? '',
    );
  }
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      title: data['Title'],
      stock: data['Stock'] ?? 0,
      thumbnail: data['Thumbnail'] ?? '',
      price: data['Price'] ?? 0,
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      tag: data['Tag'] ?? '',
    );
  }
}
