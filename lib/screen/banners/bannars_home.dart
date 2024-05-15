import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/banners/add_bannar.dart';
import 'package:d_scan_admin/screen/banners/edit_bannar.dart';
import 'package:d_scan_admin/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'model.dart'; // Import your BannerModel class

class BannersHome extends StatelessWidget {
  const BannersHome({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("bannar List"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("bannar").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }
          final List<BannerModel> banners = snapshot.data!.docs.map((doc) {
            final Map<String, dynamic> data =
                doc.data() as Map<String, dynamic>;
            return BannerModel.fromMap(doc.id, data); // Pass doc.id and data
          }).toList();
          return ListView.builder(
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: HomeColors.bgColor,
                      image: DecorationImage(
                          image: NetworkImage(banner.image), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(15)),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(EditBannar(bannarModel: banner,));
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('bannar')
                                    .doc(banner.id)
                                    .delete();
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 32,
                                color: Colors.white,
                              ))
                        ],
                      )),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddBannars());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
