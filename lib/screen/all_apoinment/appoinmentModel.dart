// Model class representing an appointment
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String patientName;
  final String doctor_name;
  final String doctorImage;
  final String doctorType;
  final String paitentid;
  final String phone;
  final DateTime date;
  final String time;
  final String id;

  AppointmentModel({
    required this.id,
    required this.paitentid,
    required this.patientName,
    required this.doctor_name,
    required this.doctorImage,
    required this.doctorType,
    required this.phone,
    required this.date,
    required this.time,
  });
}

// Fetch appointments from Firebase Firestore
Future<List<AppointmentModel>> getAppointments() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('allAppointment').get();
  return querySnapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AppointmentModel(
      id: doc.id,
      paitentid: data['id'] ?? '',
      patientName: data['patientName'] ?? '',
      doctor_name: data['doctor_name'] ?? '',
      doctorImage: data['doctorImage'] ?? '',
      doctorType: data['doctorType'] ?? '',
      phone: data['phone'] ?? '',
      date: data['date'] != null
          ? (data['date'] as Timestamp).toDate()
          : DateTime.now(),
      time: data['time'] ?? '',
    );
  }).toList();
}
