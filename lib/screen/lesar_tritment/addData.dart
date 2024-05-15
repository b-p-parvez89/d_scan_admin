import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/lesar_tritment/leserPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  late TextEditingController _nameController;
  late TextEditingController _detailsController;
  late TextEditingController _priceController;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _detailsController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('লেজার সার্ভিস অ্যাড করুণ'),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Get.to(LessarPage());
        },),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePreview(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    hintText: "Title"),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 7,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
                controller: _detailsController,
                decoration: InputDecoration(
                    labelText: 'Details',
                    border: OutlineInputBorder(),
                    hintText: "Details"),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
                controller: _priceController,
                decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                    hintText: "Price"),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                color: Colors.blue,
                onPressed: _addItem,
                child: Text('Add Item'),
              ),
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

  void _addItem() async {
    String name = _nameController.text.trim();
    String details = _detailsController.text.trim();
    String price = _priceController.text.trim();

    if (name.isNotEmpty &&
        details.isNotEmpty &&
        price.isNotEmpty &&
        _pickedImage != null) {
      try {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('leserImage/${DateTime.now().millisecondsSinceEpoch}');
        UploadTask uploadTask = storageReference.putFile(_pickedImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('leser_tridment').add({
          'name': name,
          'details': details,
          'price': price,
          'image': downloadURL,
        });

        Get.to(LessarPage());
        _nameController.clear();
        _detailsController.clear();
        _priceController.clear();
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
