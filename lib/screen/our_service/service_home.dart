import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/our_service/addService.dart';
import 'package:d_scan_admin/screen/our_service/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'servise_edit.dart';

class ServiceHome extends StatelessWidget {
  const ServiceHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "আমাদের সার্ভিস",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('service').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            //return Text('Error: ${snapshot.error}');
            print(snapshot.error);
          }
          final List<SecviceModel> items = snapshot.data!.docs.map((doc) {
            return SecviceModel.fromFirestore(doc);
          }).toList();
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                // color: Colors.deepPurple,
                child: ListTile(
                  title: Text(
                    item.name,
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                        
                          Get.to(() => ServiceEditingPage(model: item));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('service')
                              .doc(item.id)
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
          Get.to(AddServisec());
        },
        child: Icon(Icons.add),
        tooltip: "Add",
      ),
    );
  }
}
