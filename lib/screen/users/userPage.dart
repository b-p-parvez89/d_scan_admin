import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/users/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ব্যবহার কারি",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final List<UserModel> user = snapshot.data!.docs.map((doc) {
            return UserModel.fromFirestore(doc);
          }).toList();
          return ListView.builder(
            itemCount: user.length,
            itemBuilder: (context, index) {
              final _user = user[index];
              return Card(
                child: ListTile(
                  title: Text(
                    _user.name,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  subtitle: Text(_user.address),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      var telNumber = '+88' + _user.phone;
                      var uri = Uri.parse('tel:$telNumber');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'Could not launch $telNumber';
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
