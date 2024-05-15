import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/banners/bannars_home.dart';
import 'package:d_scan_admin/screen/banners/model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditBannar extends StatefulWidget {
  final BannerModel bannarModel;
  const EditBannar({required this.bannarModel});

  @override
  State<EditBannar> createState() => _EditBannarState();
}

class _EditBannarState extends State<EditBannar> {
  late TextEditingController _imageController;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    _imageController = TextEditingController(text: widget.bannarModel.image);
    super.initState();
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EDIT BANNAR IMAGE"),
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
          onPressed: _updateItem,
          color: Colors.blue,
          child: Text("UPDATE BANNAR"),
        ),
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
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

  void _updateItem() async {
    if (_pickedImage != null) {
      // Upload the new image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('bannar/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(_pickedImage!);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();

      FirebaseFirestore.instance
          .collection('bannar')
          .doc(widget.bannarModel.id)
          .update({'image': imageUrl});
    }
    Get.to(BannersHome());
  }
}
