import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/admision/AdmisionModel.dart';
import 'package:d_scan_admin/screen/admision/admisiondetails.dart';
import 'package:d_scan_admin/screen/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

class AdmissionCard extends StatelessWidget {
  final AdmisionModel admission;

  const AdmissionCard({required this.admission});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(admission.paitentName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${admission.maincouse}  ${admission.subcouse}'),
            Text('${_formatDate(admission.date)}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
                _makePhoneCall(admission.phone);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('allAdmision')
                    .doc(admission.id)
                    .delete();
              },
            ),
          ],
        ),
        onTap: () {
          Get.to(AdmissionDetailsPage(admission: admission,));
        },
       
      ),
      
    );
  }
}

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

class AdmissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(
        title: Text('Admissions'),
        leading: IconButton(
            onPressed: () {
              Get.to(HomePage());
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder<List<AdmisionModel>>(
        future: getAdmissions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<AdmisionModel>? admissions = snapshot.data;
            return ListView.builder(
              itemCount: admissions!.length,
              itemBuilder: (context, index) {
                return AdmissionCard(admission: admissions[index]);
              },
            );
          }
        },
      ),
    );
  }
}
