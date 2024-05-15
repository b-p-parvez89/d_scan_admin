import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'bannars_home.dart';

class AddBannars extends StatefulWidget {
  const AddBannars({super.key});

  @override
  State<AddBannars> createState() => _AddBannarsState();
}

class _AddBannarsState extends State<AddBannars> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bannar"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImagePreview(),
            SizedBox(
              height: 20,
            ),
            CupertinoButton(
                color: Colors.blue,
                child: Text("Choose Image"),
                onPressed: _pickImage)
          ],
        ),
      ),
      bottomSheet: Container(
        child: CupertinoButton(
          onPressed: _addItem,
          color: Colors.blue,
          child: Text("ADD BANNAR"),
        ),
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_pickedImage != null) {
      return Image.file(
        _pickedImage!,
        width: 250,
        height: 150,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        width: 250,
        height: 150,
        color: Colors.green, // Placeholder color
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

  void _addItem() async {
    if (_pickedImage != null) {
      try {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('bannar/${DateTime.now().millisecondsSinceEpoch}');
        UploadTask uploadTask = storageReference.putFile(_pickedImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('bannar').add({
          'image': downloadURL,
        });

        Get.to(BannersHome());
        _pickedImage = null;
      } catch (error) {
        print('Error adding item to Firestore: $error');
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields and select an image.'),
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
