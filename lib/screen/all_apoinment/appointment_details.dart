import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:d_scan_admin/screen/all_apoinment/appoinmentModel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'appointmentHome.dart';

class AppointmentDetailsPage extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentDetailsPage({required this.appointment});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
        leading: IconButton(
            onPressed: () {
              Get.to(MyAppointmentsScreen());
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.h,
              width: 200,
              child: Image.network(
                appointment.doctorImage,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              'ডাক্তারের নাম: ${appointment.doctor_name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'পেসেন্টের নাম: ${appointment.patientName}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SelectableText(
              'পেসেন্টের আইডি:  ${appointment.paitentid}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'পরমর্শের তারিখ: ${_formatDate(appointment.date)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'পরমর্শের সময়: ${appointment.time}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('allAppointment')
                    .doc(appointment.id)
                    .delete();
                Get.to(MyAppointmentsScreen());
              },
              child: Text('Delete Appointment'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
