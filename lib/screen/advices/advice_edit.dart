import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_scan_admin/screen/advices/adviceModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditAdviceScreen extends StatefulWidget {
  final AdviceModel advice;

  EditAdviceScreen({required this.advice});

  @override
  _EditAdviceScreenState createState() => _EditAdviceScreenState();
}

class _EditAdviceScreenState extends State<EditAdviceScreen> {
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.advice.title);
    _subtitleController = TextEditingController(text: widget.advice.subtitle);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Advice"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    hintText: "Title",
                    labelText: 'Title',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 10,
                controller: _subtitleController,
                decoration: InputDecoration(
                  labelText: 'Details',
                  hintText: 'Details',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                color: Colors.blue,
                onPressed: () async {
                  // Update advice in Firestore
                  await FirebaseFirestore.instance
                      .collection('advice')
                      .doc(widget.advice.id)
                      .update({
                    'title': _titleController.text,
                    'subtile': _subtitleController.text,
                  });
        
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
