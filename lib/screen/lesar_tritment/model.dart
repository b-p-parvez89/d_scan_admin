import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String name;
  final String details;
  final String image;
  final String price;

  Item({
    required this.id,
    required this.name,
    required this.details,
    required this.image,
    required this.price,
  });

  factory Item.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc.id,
      name: data['name'] ?? '',
      details: data['details'] ?? '',
      image: data['image'] ?? '',
      price: data['price'] ?? '', 
    );
  }
}