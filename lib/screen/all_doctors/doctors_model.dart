import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorsModel {
  final String id;
  final String nameByEngish;
  final String nameByBangla;
  final String details;
  final String image;
  final String degree; 
  final String type;
  final List <String>day;
  final List <String>time;

  DoctorsModel({
    required this.id,
    required this.nameByEngish,
    required this.nameByBangla,
    required this.details,
    required this.image,
    required this.degree,
    required this.type,
    required this.day, 
    required this.time, 
  });

  factory DoctorsModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return DoctorsModel(
      id: doc.id,
      nameByEngish: data['nameByEnglish'] ??'',
      nameByBangla: data['nameByBangla'] ?? '',
      details: data['details'] ?? '',
      image: data['image'] ?? '',
      degree: data['degree'] ?? '', 
      type: data['type'] ?? '', 
      day: List<String>.from(data['day'] ?? []), 
      time: List<String>.from(data['time'] ?? []),
    );
  }
}