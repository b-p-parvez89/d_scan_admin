import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String address;
  final String email;
  final String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      phone: data['phoneNumber'] ?? '', 
    );
  }
}