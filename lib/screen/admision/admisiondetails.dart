import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/admision/AdmisionModel.dart';
import 'package:d_scan_admin/screen/admision/admisionHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdmissionDetailsPage extends StatelessWidget {
  final AdmisionModel admission;

  const AdmissionDetailsPage({required this.admission});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(
        title: Text('Admission Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'পেসেন্টের নাম: ${admission.paitentName}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'পেসেন্টের আইডি: ${admission.paitendId}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10),
            Text(
              'কারণ: ${admission.maincouse}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'কারণ ২: ${admission.subcouse}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'পেসেন্টের মোবাইল নাম্বার: ${admission.phone}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'ভর্তির তারিখ: ${DateFormat('dd-MM-yyyy').format(admission.date)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('allAppointment')
                    .doc(admission.id)
                    .delete();
                Get.to(AdmissionScreen());
              },
              child: Text('Delete Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
