// Card widget to display appointment data
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/all_apoinment/appoinmentModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'appointment_details.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(appointment.doctorImage),
        ),
        title: Text(appointment.doctor_name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${appointment.patientName}'),
            Text('${_formatDate(appointment.date)} ${appointment.time}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
                _makePhoneCall(appointment.phone);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('allAppointment')
                    .doc(appointment.id)
                    .delete();
              },
            ),
          ],
        ),
        onTap: () {
          Get.to(AppointmentDetailsPage(
            appointment: appointment,
          ));
        },
      ),
    );
  }

  // Format date
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Function to make a phone call
  void _makePhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    try {
      Uri uri = Uri.parse(url);
      await launchUrl(uri);
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }
}

class MyAppointmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
      ),
      body: FutureBuilder<List<AppointmentModel>>(
        future: getAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<AppointmentModel>? appointments = snapshot.data;
            return ListView.builder(
              itemCount: appointments!.length,
              itemBuilder: (context, index) {
                return AppointmentCard(appointment: appointments[index]);
              },
            );
          }
        },
      ),
    );
  }
}
