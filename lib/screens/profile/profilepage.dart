// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class Profilepage extends StatelessWidget {
  Profilepage({Key? key}) : super(key: key);

  File? _image;
  String? imageUrl;
  final _picker = ImagePicker();
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

  // final Stream<QuerySnapshot> _userstream =
  //     FirebaseFirestore.instance.collection('users').where("u") snapshots();

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  updateField(String field,  String data) {
    final ref = FirebaseFirestore.instance;
    ref.collection('users').doc(auth.currentUser!.email).update({field: data});
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile? image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/${image.path.replaceRange(1, 20, '')}')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  final auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: (imageUrl != null)
                    ? Image.network(imageUrl!)
                    : Text('Select Image'),
                radius: 80,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: FloatingActionButton(
                  child: Icon(Icons.add_a_photo_outlined),
                  onPressed: () async {
                    uploadImage();
                  }),
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text('Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text('Number'),
                ),
                SizedBox(
                  width: 0,
                ),
                Container(
                  //margin: EdgeInsets.only(left: 10),
                  //padding: EdgeInsets.only(right: 20),
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.67,
                  child: TextField(
                    controller: numberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text('Email'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.71,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
