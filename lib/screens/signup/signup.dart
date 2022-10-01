// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foundit/components/custom_dialog.dart';
import 'package:foundit/constants/custom_textstyle.dart';
import 'package:foundit/models/user_model.dart';
import 'package:foundit/screens/home/homepage.dart';
import 'package:foundit/screens/login/loginpage.dart';
import 'package:foundit/sizeconfig.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  File? _image;
  String? imageUrl;
  bool isLoading = false;
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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    return Scaffold(
      body: Stack(children: [
        AbsorbPointer(
          absorbing: isLoading,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Row(
                        children: [],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 50),
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: GestureDetector(
                              onTap: () async {
                                uploadImage();
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  //borderRadius: BorderRadius.circular(200),
                                ),
                                child: (imageUrl != null)
                                    ? Image(
                                        image: NetworkImage(imageUrl!),
                                        fit: BoxFit.cover,
                                      )
                                    : Center(child: Text('Select Image')),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                              ),
                              onSaved: (String? value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (String? value) {
                                return (value == null ||
                                        value.contains('@') ||
                                        !value.contains(RegExp(r'[A-Z]')))
                                    ? 'Enter valid name'
                                    : null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          // key: key,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          validator: (String? value) {
                            return (value == null || !value.contains('@'))
                                ? 'enter valid email'
                                : null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          //  key: key,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (String? value) {
                            return (value == null || value.length < 8)
                                ? 'password should be strong and more than 7 characters'
                                : null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.80,
                        // width: 500,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: numberController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                          ),
                          validator: (String? value) {
                            return (value == null ||
                                    value.contains(RegExp(r'[A-Z]')))
                                ? 'enter valid number'
                                : null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              // Create a new user with a first and last name

                              await auth.createUserWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());

                              //
                              final user = UserModel(
                                  name: nameController.text,
                                  password: passwordController.text,
                                  number: numberController.text,
                                  email: emailController.text,
                                  image: imageUrl);
                              final docRef = db
                                  .collection("users")
                                  .withConverter(
                                    fromFirestore: UserModel.fromFirestore,
                                    toFirestore: (UserModel user, options) =>
                                        user.toFirestore(),
                                  )
                                  .doc(auth.currentUser!.uid);
                              await docRef.set(user);

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => Homepage()),
                                  (route) => false);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (ctx) => Homepage()));
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              log(e.toString());
                              CustomDialog(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  content: e.toString());
                            }
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text('Processing Data')),
                            // );
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: Center(
                            child: Text(
                              'Create Account',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text('Already have an account?'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Loginpage(),
                                  ),
                                );
                              },
                              child: Text(
                                'LogIn',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const Homepage(),
                      //       ),
                      //     );
                      //   },
                      //   child: Text('Skip'),
                      // )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        isLoading
            ? Align(
                alignment: Alignment.center,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : SizedBox.shrink()
      ]),
    );
  }
}
