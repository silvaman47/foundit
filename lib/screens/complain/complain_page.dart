// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/models/complain_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/custom_dialog.dart';
import '../item_screen/itemscreen.dart';

class ComplainPage extends StatefulWidget {
  const ComplainPage({Key? key}) : super(key: key);

  @override
  State<ComplainPage> createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {
  File? _image;

  final _picker = ImagePicker();

  get db => null;
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complain'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: ElevatedButton(
                    child: const Text('Select An Image'),
                    onPressed: _openImagePicker,
                  ),
                ),
                const SizedBox(height: 35),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 220,
                  color: Colors.grey[300],
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.contain)
                      : const Text('Please select an image'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(right: 280),
                  child: Text(
                    'Location',
                  ),
                ),
                SizedBox(
                  // margin: EdgeInsets.only(right: 290),
                  //  padding: EdgeInsets.symmetric(horizontal: 100),
                  width: double.infinity,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  // margin: EdgeInsets.only(right: 280),
                  child: Text(
                    'Description',
                  ),
                ),
                SizedBox(
                  // margin: EdgeInsets.only(right: 290),
                  //  padding: EdgeInsets.symmetric(horizontal: 100),
                  width: double.infinity,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  //margin: EdgeInsets.only(right: 280),
                  child: Text(
                    'Date',
                  ),
                ),
                SizedBox(
                  // margin: EdgeInsets.only(right: 290),
                  //  padding: EdgeInsets.symmetric(horizontal: 100),
                  width: double.infinity,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  //margin: EdgeInsets.only(right: 280),
                  child: Text(
                    'Time Lost',
                  ),
                ),
                SizedBox(
                  // margin: EdgeInsets.only(right: 290),
                  //  padding: EdgeInsets.symmetric(horizontal: 100),
                  width: double.infinity,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      // Create a new user with a first and last name
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => ItemScreen()));
                      //
                      final user = Complaint(
                        user: '',
                        image: '',
                        location: '',
                        status: '',
                        description: '',
                        latitude: null,
                        longitude: null,
                        dateTime: null,
                        finders: [],
                      );
                      var emailController;
                      final docRef = db
                          .collection("users")
                          .withConverter(
                            fromFirestore: Complaint.fromFirestore,
                            toFirestore: (Complaint user, options) =>
                                user.toFirestore(),
                          )
                          .doc(emailController.text.trim());
                      await docRef.set(user);
                    } on FirebaseAuthException catch (e) {
                      log(e.toString());
                      CustomDialog(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          content: e.toString());
                    }
                  },
                  child: Container(
                   // margin: EdgeInsets.only(top: 10, left: 50, right: 10),
                    height: 60,
                    width: double.infinity,
                    child: Center(child: Text('Submit')),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
