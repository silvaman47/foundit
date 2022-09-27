// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_function_type_syntax_for_parameters, unnecessary_null_comparison, prefer_if_null_operators, duplicate_ignore, unused_field, override_on_non_overriding_member

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foundit/constants/custom_textstyle.dart';
import 'package:foundit/screens/login/loginpage.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

// ignore: must_be_immutable

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String name = '';
  // TextEditingController? nameController;
  // TextEditingController? userNameController;
  // TextEditingController? phoneController;
  // TextEditingController? bioController;

  String email = '';
  String phone = '';
  String number = '';
  String password = '';
  File? _image;
  bool chosenDp = false;

//fetch image from device
  Future getImage() async {
    try {
      final pickedFile = await ImagePicker()
          .pickImage(imageQuality: 50, source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);

          chosenDp = true;
        } else {
          print('No image selected');
        }
      });
    } on PlatformException catch (e) {
      print('exception thrown');
    }
  }

//save image url to firestore
  Future<void> saveImage(File _image, String uid) async {
    String imageURL = await uploadFile(_image);
    DocumentReference profilePicsRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    profilePicsRef.update(
      {
        "profile": imageURL,
      },
    );
  }

//upload image to cloud storage then get url
  Future<String> uploadFile(File _image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('images/${path.basename(_image.path)}}');
    try {
      UploadTask uploadTask = ref.putFile(_image);
      await uploadTask.whenComplete(() => print('File Uploaded'));
    } on FirebaseException catch (e) {
      //print(e.code);
    }
    String? returnURL;
    await ref.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
      // NickNameAvatar.updateURl = fileURL;
    });
    return returnURL!;
  }

//Update new name on cloud
  Future<void> updateName(String name, String uid) async {
    // String imageURL = await uploadFile(_image);
    DocumentReference nameRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    nameRef.update(
      {
        "name": name,
      },
    );
  }

//phone
  Future<void> updatenumber(String number, String uid) async {
    // String imageURL = await uploadFile(_image);
    DocumentReference phoneRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    phoneRef.update(
      {
        "number": number,
      },
    );
  }

  Future<void> updateemail(String email, String uid) async {
    // String imageURL = await uploadFile(_image);
    DocumentReference emailRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    emailRef.update(
      {
        "email": email,
      },
    );
  }

  Future<void> updatepassword(String password, String uid) async {
    // String imageURL = await uploadFile(_image);
    DocumentReference passwordRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    passwordRef.update(
      {
        "password": password,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Profile',
          style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Loading'),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              final data = snapshot.data;

              return SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      //backgroundColor: Colors.purple,
                      height: 100,
                      width: 100,
                      child: CachedNetworkImage(
                        imageUrl: '${data!['image']}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      getImage().then(
                        (value) => saveImage(_image!, _auth.currentUser!.uid)
                            .then((value) => ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                    content: Text('Profile updated')))),
                      );
                    },
                    child: Text(
                      'Change profile photo',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      //controller: nameController,
                      initialValue: '${data['name']}' == null
                          ? 'Enter your name'
                          : '${data['name']}',
                      decoration: InputDecoration(label: Text('Name')),
                      keyboardType: TextInputType.name,
                      maxLength: 30,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      ],
                      onFieldSubmitted: (value) async {
                        setState(() {
                          name = value;
                        });

                        updateName(name, _auth.currentUser!.uid).then((value) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Profile updated'))));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      //controller: phoneController,
                      initialValue: '${data['number']}' == null
                          ? 'Enter your phone number'
                          : '${data['number']}',
                      decoration: InputDecoration(label: Text('Phone Number')),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                      maxLength: 10,
                      onFieldSubmitted: (value) async {
                        setState(() {
                          phone = value;
                        });
                        updatenumber(phone, _auth.currentUser!.uid).then(
                            (value) => ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                    content: Text('Profile updated'))));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      //controller: nameController,
                      initialValue: '${data['email']}' == null
                          ? 'Enter your email'
                          : '${data['email']}',
                      decoration: InputDecoration(label: Text('Email')),
                      keyboardType: TextInputType.name,
                      maxLength: 30,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      ],
                      onFieldSubmitted: (value) async {
                        setState(() {
                          name = value;
                        });

                        updateemail(name, _auth.currentUser!.uid).then(
                            (value) => ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                    content: Text('Profile updated'))));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      //controller: nameController,
                      initialValue: '${data['password']}' == null
                          ? 'Enter your password'
                          : '${data['password']}',
                      decoration: InputDecoration(label: Text('Password')),
                      keyboardType: TextInputType.name,
                      maxLength: 30,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      ],
                      onFieldSubmitted: (value) async {
                        setState(() {
                          name = value;
                        });

                        updatepassword(name, _auth.currentUser!.uid).then(
                            (value) => ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                    content: Text('Profile updated'))));
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content: Text('Log Out'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  signOut();
                                },
                                child: Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No'),
                              ),
                            ],
                          ),
                        );
                        signOut();
                      },
                      child: Text('Logout'))
                ]),
              );
            }
          },
        ),
      ),
    );
  }

  signOut() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (ctx) => Loginpage()), (route) => false);
  }
}
