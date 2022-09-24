// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foundit/constants/custom_textstyle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class Profilepage extends StatelessWidget {
  Profilepage({Key? key}) : super(key: key);

  updateProfileData() {
    setState(() {
      nameController.text.trim().length < 3 || nameController.text.isEmpty
          ? _nameValid = false
          : _nameValid = true;
      numberController.text.trim().length < 10
          ? _numberValid = false
          : _numberValid = true;
      passwordController.text.trim().length < 6
          ? _passwordValid = false
          : _passwordValid = true;
    });
    if (_nameValid && _numberValid && _passwordValid) {
      final ref = FirebaseFirestore.instance;
    }
  }

  final auth = FirebaseAuth.instance;
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
  TextEditingController passwordController = TextEditingController();
  bool _nameValid = true;
  bool _numberValid = true;
  bool _emailValid = true;
  bool _passwordValid = true;
  updateField(String field, String data) {
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: customtextstyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 150,
                height: 150,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.circular(30),
                ),
                child: (imageUrl != null)
                    ? Image(
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : Center(child: Text('Select Image')),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 0,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: numberController,
                decoration: const InputDecoration(
                  labelText: 'Number',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: updateProfileData(),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
