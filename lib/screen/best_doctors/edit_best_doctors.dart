import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/all_doctors/doctors_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditBestDoctors extends StatefulWidget {
  final DoctorsModel model;
  const EditBestDoctors({required this.model});

  @override
  State<EditBestDoctors> createState() => _EditBestDoctorsState();
}

class _EditBestDoctorsState extends State<EditBestDoctors> {
  late TextEditingController nameByBanglaController;
  late TextEditingController nameByEnglishController;
  late TextEditingController detailsController;
  late TextEditingController degreeController;
  late TextEditingController typeController;

  File? _pickedImage;
  String? _imageUrl; // Variable to store image URL
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
    nameByBanglaController =
        TextEditingController(text: widget.model.nameByBangla);
    nameByEnglishController =
        TextEditingController(text: widget.model.nameByEngish);
    typeController = TextEditingController(text: widget.model.type);
    degreeController = TextEditingController(text: widget.model.degree);
    detailsController = TextEditingController(text: widget.model.details);
    selectedDays = widget.model.day;
    time = widget.model.time;
    _pickedImage = null; // Initialize _pickedImage to null
    _imageUrl = widget.model.image; // Assign image URL
  }

  @override
  void dispose() {
    super.dispose();
    nameByBanglaController.dispose();
    nameByEnglishController.dispose();
    typeController.dispose();
    degreeController.dispose();
    detailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            "Update Doctors",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: _updateDoctors,
        ),
      ),
      appBar: AppBar(
        title: Text("Update Doctor"),
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
                                print(selectedDays);
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
    } else if (_imageUrl != null && _imageUrl!.isNotEmpty) {
      return Image.network(
        _imageUrl!,
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
        _imageUrl = null; // Reset image URL when a new image is picked
      });
    }
  }

  void _updateDoctors() async {
    String nameByEnglish = nameByEnglishController.text.trim();
    String nameByBangla = nameByBanglaController.text.trim();
    String details = detailsController.text.trim();
    String degree = degreeController.text.trim();
    String type = typeController.text.trim();

    // Check if all required fields are not empty
    if (nameByEnglish.isNotEmpty &&
        details.isNotEmpty &&
        degree.isNotEmpty &&
        type.isNotEmpty) {
      DocumentReference doctorRef = FirebaseFirestore.instance
          .collection("best_doctor")
          .doc(widget.model.id);
      Map<String, dynamic> updatedValue = {
        'nameByBangla': nameByBangla,
        'nameByEnglish': nameByEnglish,
        'details': details,
        'type': type,
        'day': selectedDays,
        'time': time,
        'image': _imageUrl, // Use the image URL directly
      };

      // Fetch the image URL from Firebase Storage if it exists
      if (_pickedImage != null) {
        // If a new image is picked, upload it to Firebase Storage
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('BestDoctors/${DateTime.now().millisecondsSinceEpoch}');
        UploadTask uploadTask = storageReference.putFile(_pickedImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        updatedValue['image'] =
            downloadURL; // Update 'image' field with download URL
      }

      // Update Firestore document with the updated values
      doctorRef.update(updatedValue).then((value) {
        Navigator.pop(context);
      }).catchError((error) {
        print('Error updating item: $error');
      });
    } else {
      // Show error dialog if any required field is empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('All fields are required.'),
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
