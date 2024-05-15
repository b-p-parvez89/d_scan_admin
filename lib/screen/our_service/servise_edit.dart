import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/our_service/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceEditingPage extends StatefulWidget {
  final SecviceModel model;
  const ServiceEditingPage({super.key, required this.model});

  @override
  State<ServiceEditingPage> createState() => _ServiceEditingPageState();
}

class _ServiceEditingPageState extends State<ServiceEditingPage> {
  late TextEditingController _nameController;
  late TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.model.name);
    _detailsController = TextEditingController(text: widget.model.details);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();

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
              TextFormField(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    hintText: "Title"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 10,
                controller: _detailsController,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                    labelText: 'Details',
                    border: OutlineInputBorder(),
                    hintText: "Details"),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                color: Colors.blue,
                onPressed: _updateItem,
                child: Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateItem() async {
    try {
      // Access Firestore collection
      final collection = FirebaseFirestore.instance.collection('service');

      // Update document with new values
      await collection.doc(widget.model.id).update({
        'title': _nameController.text,
        'subtitle': _detailsController.text,
      });

      // Show success message or navigate back
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Item updated successfully'),
      ));
      Navigator.pop(context); // Navigate back to previous screen
    } catch (e) {
      // Handle errors
      print('Error updating item: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update item. Please try again later.'),
      ));
    }
  }
}
