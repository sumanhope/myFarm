import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfarm/features/personalization/models/addressmodal.dart';
import 'package:myfarm/features/store/models/cartmodel.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final String status;
  final double totalAmount;
  final DateTime orderDate;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.address,
    this.deliveryDate,
  });

  String get formattedOrderDate => MFHelperFunctions.getFormattedDate(orderDate);
  String get formattedDeliveryData => deliveryDate != null ? MFHelperFunctions.getFormattedDate(deliveryDate!) : '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status,
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      status: data['status'] as String,
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      deliveryDate: data['deliveryDate'] == null ? null : (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
    );
  }
}
