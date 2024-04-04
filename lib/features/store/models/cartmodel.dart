class CartItemModel {
  String productId;
  String title;
  int price;
  String? image;
  int quantity;
  String? categoryId;
  String? tag;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.categoryId = "",
    this.image,
    this.price = 0,
    this.title = '',
    this.tag = '',
  });

  static CartItemModel empty() => CartItemModel(
        productId: "",
        quantity: 0,
        categoryId: "",
      );

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'tag': tag,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      categoryId: json['categoryId'],
      quantity: json['quantity'],
      title: json['title'],
      price: json['price'],
      image: json['image'],
      tag: json['tag'],
    );
  }
}
