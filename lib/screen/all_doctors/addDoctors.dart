import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/all_doctors/doctors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  late TextEditingController nameByBanglaController;
  late TextEditingController nameByEnglishController;
  late TextEditingController detailsController;
  late TextEditingController degreeController;
  late TextEditingController typeController;

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  List<String> availableDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List<String> time = [];
  List<String> selectedDays = [];
  TextEditingController timeController = TextEditingController();

  void selectDay(String day) {
    setState(() {
      selectedDays.add(day);
    });
  }

  void deselectDay(String day) {
    setState(() {
      selectedDays.remove(day);
    });
  }

  @override
  void initState() {
    super.initState();
    nameByBanglaController = TextEditingController();
    nameByEnglishController = TextEditingController();
    typeController = TextEditingController();
    degreeController = TextEditingController();
    detailsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(

      bottomSheet: Container(
        decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          child: Text(
            "Add Doctors",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: _addDoctor,
        ),
      ),
      appBar: AppBar(
        title: Text("Add Doctor"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildImagePreview(),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: _pickImage, child: Text("Pick Image")),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameByEnglishController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input Doctor Name English",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameByBanglaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input Doctor Name Bangla",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: degreeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input Doctor's Degree",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: typeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input Doctor's Type",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: detailsController,
                maxLines: 7,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input Doctor Details",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Day",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: availableDays.length,
                        itemBuilder: (context, index) {
                          final day = availableDays[index];
                          final isSelected = selectedDays.contains(day);

                          return Padding(
                            padding: EdgeInsets.only(right: 3),
                            child: InkWell(
                              onTap: () {
                                if (isSelected) {
                                  deselectDay(day);
                                } else {
                                  selectDay(day);
                                }
                               
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.purple
                                        : Colors.blue,
                                    borderRadius: BorderRadius.circular(12)),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Center(
                                  child: Text(availableDays[index]),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Time",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 60,
                      child: ListView.builder(
                        itemCount: time.length + 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == time.length) {
                            return Padding(
                              padding: EdgeInsets.only(right: 3),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Add New Time'),
                                        content: TextField(
                                          controller: timeController,
                                        ),
                                        actions: <Widget>[
                                          CupertinoButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          CupertinoButton(
                                            onPressed: () {
                                              setState(() {
                                                time.add(timeController.text);
                                                timeController.clear();
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Add'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 32,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    time.removeAt(index);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Text(time[index]),
                                        Icon(Icons.delete),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_pickedImage != null) {
      return Image.file(
        _pickedImage!,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        width: 150,
        height: 150,
        color: Colors.grey, // Placeholder color
      );
    }
  }

  void _pickImage() async {
    final pickedImageFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }

  void _addDoctor() async {
    String nameByEnglish = nameByEnglishController.text.trim();
    String nameByBangla = nameByBanglaController.text.trim();
    String details = detailsController.text.trim();
    String degree = degreeController.text.trim();
    String type = typeController.text.trim();

    // Check if all required fields are not empty
    if (nameByEnglish.isNotEmpty &&
        nameByBangla.isNotEmpty &&
        details.isNotEmpty &&
        degree.isNotEmpty &&
        type.isNotEmpty) {
      try {
        // If an image is selected, upload it to Firebase Storage
        String imageUrl = '';
        if (_pickedImage != null) {
          Reference storageReference = FirebaseStorage.instance
              .ref()
              .child('Doctorsimages/${DateTime.now().millisecondsSinceEpoch}');
          UploadTask uploadTask = storageReference.putFile(_pickedImage!);
          TaskSnapshot taskSnapshot = await uploadTask;
          imageUrl = await taskSnapshot.ref.getDownloadURL();
        }

        // Add doctor details to Firestore
        await FirebaseFirestore.instance.collection('all_doctors').add({
          'nameByBangla': nameByBangla,
          'nameByEnglish': nameByEnglish,
          'details': details,
          'degree': degree,
          'type': type,
          'image':
              imageUrl, // Use imageUrl if available, otherwise empty string
          'day': selectedDays,
          'time': time
        });

        Get.to(DoctorHome());
        nameByBanglaController.clear();
        nameByEnglishController.clear();
        degreeController.clear();
        detailsController.clear();
        typeController.clear();
      } catch (error) {
        print('Error adding item to Firestore: $error');
      }
    } else {
      // Show error dialog if any required field is empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
