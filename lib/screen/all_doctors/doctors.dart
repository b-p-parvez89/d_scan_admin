
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/all_doctors/doctors_model.dart';
import 'package:d_scan_admin/screen/all_doctors/editDoctors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../home/homepage.dart';
import 'addDoctors.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Doctors",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(HomePage());
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('all_doctors').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: SelectableText('Error: ${snapshot.error}'));
          }
          final List<DoctorsModel> doctors = snapshot.data!.docs.map((doc) {
            return DoctorsModel.fromFirestore(doc);
          }).toList();
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return Card(
                child: ListTile(
                  title: Text(
                    doctor.nameByEngish,
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                  subtitle: Text(doctor.degree),
                  leading: doctor.image.isNotEmpty
                      ? Image.network(
                          doctor.image,
                          width: 50.h,
                          height: 50.h,
                          fit: BoxFit.fill,
                        )
                      : Container(
                          width: 60.w,
                          height: 60.h,
                          color: Colors.blue,
                        ),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                         Get.to(() => EditDoctors(model: doctor));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('all_doctors')
                              .doc(doctor.id)
                              .delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Get.to(() => AddDoctor());
        },
        child: Icon(Icons.add),
        tooltip: "Add",
      ),
    );
  }
}
