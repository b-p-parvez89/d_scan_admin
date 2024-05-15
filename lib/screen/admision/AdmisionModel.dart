import 'package:cloud_firestore/cloud_firestore.dart';

class AdmisionModel {
  final String paitentName;
  final String paitendId;
  final String maincouse;
  final String subcouse;
  final String phone;
  final DateTime date;
  final String id;

  AdmisionModel(
      {required this.paitentName,
      required this.paitendId,
      required this.maincouse,
      required this.subcouse,
      required this.phone,
      required this.date,
      required this.id});
}

Future<List<AdmisionModel>> getAdmissions() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('allAdmision').get();
  return querySnapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AdmisionModel(
        paitentName: data['patientName'] ?? '',
        paitendId: data['id'] ?? '',
        maincouse: data['maincouse'] ?? '',
        subcouse: data['subcouse'] ?? '',
        phone: data['phone'] ?? '',
        date: data['date'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                data['date'].millisecondsSinceEpoch)
            : DateTime.now(),
        id: doc.id);
  }).toList();
}
