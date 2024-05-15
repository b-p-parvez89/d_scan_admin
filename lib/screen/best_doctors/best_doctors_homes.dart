import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/all_doctors/doctors_model.dart';
import 'package:d_scan_admin/screen/best_doctors/add_best_doctors.dart';
import 'package:d_scan_admin/screen/best_doctors/edit_best_doctors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../home/homepage.dart';

class BestDoctors extends StatelessWidget {
  const BestDoctors({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Best Doctors",
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
            FirebaseFirestore.instance.collection('best_doctor').snapshots(),
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
                          Get.to(() => EditBestDoctors(model: doctor));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('best_doctor')
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
          Get.to(() => AddBestDoctor());
        },
        child: Icon(Icons.add),
        tooltip: "Add",
      ),
    );
  }
}
