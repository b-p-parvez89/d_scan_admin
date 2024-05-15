import 'dart:io';

import 'package:d_scan_admin/screen/lesar_tritment/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditItemScreen extends StatefulWidget {
  final Item item;

  const EditItemScreen({required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController _nameController;
  late TextEditingController _detailsController;
  late TextEditingController _imageController;
  late TextEditingController _priceController;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _detailsController = TextEditingController(text: widget.item.details);
    _imageController = TextEditingController(text: widget.item.image);
    _priceController = TextEditingController(text: widget.item.price);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _imageController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePreview(),
              SizedBox(height: 10),
              CupertinoButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
                decoration: InputDecoration(
                    hintText: "Name or Title",
                    labelText: 'Name',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  maxLines: 8,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  controller: _detailsController,
                  decoration: InputDecoration(
                    labelText: 'Details',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                    labelText: 'Price', border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                color: Colors.blue,
                onPressed: () {
                  _updateItem();
                },
                child: Text('Update Data'),
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
      final imageUrl = widget.item.image;
      if (imageUrl.isNotEmpty) {
        return Image.network(
          imageUrl,
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

  void _updateItem() {
    String name = _nameController.text.trim();
    String details = _detailsController.text.trim();
    String price = _priceController.text.trim();

    if (name.isNotEmpty && details.isNotEmpty && price.isNotEmpty) {
      DocumentReference itemRef = FirebaseFirestore.instance
          .collection('leser_tridment')
          .doc(widget.item.id);

      Map<String, dynamic> updatedValues = {
        'name': name,
        'details': details,
        'price': price,
      };

      if (_pickedImage != null) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}');
        UploadTask uploadTask = storageReference.putFile(_pickedImage!);
        uploadTask.then((TaskSnapshot taskSnapshot) async {
          String downloadURL = await taskSnapshot.ref.getDownloadURL();
          updatedValues['image'] =
              downloadURL; // Update 'image' field with download URL
          itemRef.update(updatedValues).then((value) {
            Navigator.pop(context);
          }).catchError((error) {
            print('Error updating item: $error');
          });
        }).catchError((error) {
          print('Error uploading image: $error');
        });
      } else {
        itemRef.update(updatedValues).then((value) {
          Navigator.pop(context);
        }).catchError((error) {
          print('Error updating item: $error');
        });
      }
    } else {
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
