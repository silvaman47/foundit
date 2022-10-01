// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_element

import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foundit/models/complain_model.dart';
import 'package:foundit/models/user_model.dart';
import 'package:foundit/screens/home/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:permission_handler/permission_handler.dart';

import '../../components/custom_dialog.dart';
import '../item_screen/itemscreen.dart';

class ComplainPage extends StatefulWidget {
  const ComplainPage({
    Key? key,
    required this.latlong,
  }) : super(key: key);
  final LatLng latlong;
  @override
  State<ComplainPage> createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {
  File? _image;
  String? imageUrl;
  // final _picker = ImagePicker();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  DateTime? lostDate;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  // Implementing the image picker

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
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complain',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      body: Stack(children: [
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Column(
                children: <Widget>[
                  Center(
                    child: ElevatedButton(
                        child: const Text(
                          'Select An Image',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          uploadImage();
                        }),
                  ),
                  const SizedBox(height: 35),
                  Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 220,
                      color: Colors.grey[300],
                      child: (imageUrl != null)
                          ? Image.network(imageUrl!)
                          : Text('Select Image')),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 265),
                    child: Text(
                      'Location',
                    ),
                  ),
                  SizedBox(
                    // margin: EdgeInsets.only(right: 290),
                    //  padding: EdgeInsets.symmetric(horizontal: 100),
                    width: double.infinity,
                    height: 40,
                    child: TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      validator: (String? value) {
                        return value!.isEmpty ? 'empty field' : null;
                      },
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
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      validator: (String? value) {
                        return value!.isEmpty ? 'empty field' : null;
                      },
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
                    width: double.infinity,
                    height: 40,
                    child: TextFormField(
                      // initialValue: dateController.text,
                      controller: dateController,
                      readOnly: true,
                      validator: (String? value) {
                        return value!.isEmpty ? 'empty field' : null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);

                          setState(() {
                            dateController.text = formattedDate;
                          });
                        } else {
                          print('date is not selected');
                        }
                      },
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text('Time'),
                  ),
                  SizedBox(
                    // margin: EdgeInsets.only(right: 290),
                    //  padding: EdgeInsets.symmetric(horizontal: 100),
                    width: double.infinity,
                    height: 40,
                    child: TextFormField(
                      // initialValue: timeController.text ?? 'pick time',
                      readOnly: true,
                      validator: (String? value) {
                        return value!.isEmpty ? 'empty field' : null;
                      },

                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
                        if (pickedTime != null) {
                          print(pickedTime.format(context));
                          // DateTime parsedTime = DateFormat.jm()
                          //     .parse(pickedTime.format(context).toString());
                          //print(parsedTime);

                          String formattedTime = DateFormat("HH:mm:ss").format(
                              DateTime(
                                  0, 0, 0, pickedTime.hour, pickedTime.minute));
                          // print(formattedTime);

                          setState(() {
                            timeController.text = formattedTime;
                          });
                        } else {
                          print("time is not selected");
                        }
                      },
                      controller: timeController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 265),
                    child: Text(
                      'Number',
                    ),
                  ),
                  SizedBox(
                    // margin: EdgeInsets.only(right: 290),
                    //  padding: EdgeInsets.symmetric(horizontal: 100),
                    width: double.infinity,
                    height: 40,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: numberController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      validator: (String? value) {
                        return value!.isEmpty ? 'empty field' : null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate() && imageUrl != '') {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          print(imageUrl);
                          final docRef = db.collection("complaints").doc();
                          final complaint = {
                            "id": docRef.id,
                            "owner": auth.currentUser!.email,
                            "image": imageUrl,
                            "location": locationController.text.trim(),
                            "status": 'lost',
                            "description": descriptionController.text.trim(),
                            "latitude": widget.latlong.latitude,
                            "longitude": widget.latlong.longitude,
                            "dateTime": lostDate ?? DateTime.now(),
                            "ownernum": numberController.text.trim(),
                          };
                          await docRef.set(complaint).onError(
                              (error, stackTrace) =>
                                  print("error writing doc: $e"));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (ctx) => Homepage()),
                              (route) => false);
                        } on FirebaseException catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          dev.log(e.code);
                          CustomDialog(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              content: e.toString());
                        }

                        // CustomDialog(
                        //     onPressed: () {

                        //     },
                        //     content: 'Complaint uploaded');
                      } else {
                        CustomDialog(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            content: 'Please fill all fields');
                      }
                    },
                    child: Container(
                      // margin: EdgeInsets.only(top: 10, left: 50, right: 10),
                      height: 60,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      )),
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
