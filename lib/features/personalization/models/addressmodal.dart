import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  final String name;
  final String phonenumber;
  final String city;
  final String postal;
  final String country;
  //DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phonenumber,
    required this.city,
    required this.postal,
    required this.country,
    //this.dateTime,
    this.selectedAddress = true,
  });

  static AddressModel empty() => AddressModel(
        id: "",
        name: "",
        phonenumber: "",
        city: "",
        postal: "",
        country: "",
        selectedAddress: true,
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phonenumber,
      'Postal': postal,
      'City': city,
      'Country': country,
      //'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phonenumber: data['PhoneNumber'] as String,
      city: data['City'] as String,
      postal: data['Postal'] as String,
      country: data['Country'] as String,
      selectedAddress: data['SelectedAddress'] as bool,
      //dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phonenumber: data['PhoneNumber'] ?? '',
      city: data['City'] ?? '',
      postal: data['Postal'] ?? '',
      country: data['Country'] ?? '',
      selectedAddress: data['SelectedAddress'] as bool,
      //dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  @override
  String toString() {
    return '$city, $postal, $country';
  }
}
