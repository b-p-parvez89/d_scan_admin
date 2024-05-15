import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/home/homepage.dart';
import 'package:d_scan_admin/screen/lesar_tritment/addData.dart';
import 'package:d_scan_admin/screen/lesar_tritment/editPage.dart';
import 'package:d_scan_admin/screen/lesar_tritment/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LessarPage extends StatelessWidget {
  const LessarPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "লেজার ট্রিটমেন্ট",
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
            FirebaseFirestore.instance.collection('leser_tridment').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: SelectableText('Error: ${snapshot.error}'));
          }
          final List<Item> treatments = snapshot.data!.docs.map((doc) {
            return Item.fromFirestore(doc);
          }).toList();
          return ListView.builder(
            itemCount: treatments.length,
            itemBuilder: (context, index) {
              final treatment = treatments[index];
              return Card(
                child: ListTile(
                  title: Text(
                    treatment.name,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  subtitle: Text('Price: \৳${treatment.price}'),
                  leading: treatment.image.isNotEmpty
                      ? Image.network(
                          treatment.image,
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
                          Get.to(() => EditItemScreen(item: treatment));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('leser_tridment')
                              .doc(treatment.id)
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
          Get.to(() => AddItem());
        },
        child: Icon(Icons.add),
        tooltip: "Add",
      ),
    );
  }
}
