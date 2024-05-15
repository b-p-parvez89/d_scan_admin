import 'package:cloud_firestore/cloud_firestore.dart';

class SecviceModel {
  final String id;
  final String name;
  final String details;

  SecviceModel({
    required this.id,
    required this.name,
    required this.details,
  });

  factory SecviceModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return SecviceModel(
      id: doc.id,
      name: data['title'] ?? '',
      details: data['subtitle'] ?? '',
    );
  }
}
