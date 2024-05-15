import 'package:cloud_firestore/cloud_firestore.dart';

class AdviceModel {
  final String id;
  final String title;
  final String subtitle;

  AdviceModel({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  factory AdviceModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AdviceModel(
      id: doc.id,
      title: data['title'] ?? '',
      subtitle: data['subtile'] ?? '',
    );
  }
}

Future<List<AdviceModel>> getAdviceModels() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('advice').get();
  return querySnapshot.docs.map((doc) {
    return AdviceModel.fromFirestore(doc);
  }).toList();
}
