import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/advices/adviceModel.dart';
import 'package:d_scan_admin/screen/advices/advice_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'addAdvices.dart';

class AdviceScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(
        title: Text("Advice Screen"),
      ),
      body: FutureBuilder<List<AdviceModel>>(
        future: getAdviceModels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<AdviceModel>? adviceModels = snapshot.data;
            return ListView.builder(
              itemCount: adviceModels!.length,
              itemBuilder: (context, index) {
                final AdviceModel advice = adviceModels[index];
                return Card(
                  child: ListTile(
                    title: Text(advice.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Get.to(EditAdviceScreen(advice: advice));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            // Delete item from Firestore
                            await FirebaseFirestore.instance
                                .collection('advice')
                                .doc(advice.id)
                                .delete();

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => AdviceScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddAdviceScreen());
        },
        child: Icon(Icons.add),
        tooltip: "Add Data",
      ),
    );
  }
}
