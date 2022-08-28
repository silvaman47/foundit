// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_element

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foundit/models/complain_model.dart';
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
  final _picker = ImagePicker();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  DateTime? lostDate;
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    // await Permission.photos.request();
    // var permissionStatus = await Permission.photos.status;

    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<String?> uploadImage(File? image) async {
    final _firebaseStorage = FirebaseStorage.instance;
    //final imageRef = _firebaseStorage.ref("images/${image!.path}");
    final ref =
        _firebaseStorage.ref('images/${image!.path.replaceRange(1, 20, '')}');
    if (image != null) {
      //Upload to Firebase
      try {
        await ref.putFile(image);
        //image fetched
        // await imageRef.getDownloadURL();
        // setState(() {
        // var downloadUrl =
        // setState(() {
        //   imageUrl = downloadUrl;
        // });
        // });

        // setState(() {
        //   imageUrl = downloadUrl;
        // });
      } on FirebaseException catch (e) {
        log(e.code);
      }
    } else {
      print('No Image Path Received');
    }

    return await ref.getDownloadURL();
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
                      onPressed: () async {
                        if (await Permission.storage.request().isGranted) {
                          _openImagePicker();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: SnackBar(
                                  content:
                                      Text("PLease allow storage access"))));
                        }
                      }),
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
                  child: TextFormField(
                    controller: locationController,
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
                    controller: descriptionController,
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
                  width: double.infinity,
                  height: 40,
                  child: TextFormField(
                    // initialValue: dateController.text,
                    controller: dateController,
                    readOnly: true,
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
                GestureDetector(
                  onTap: () async {
                    try {
                      uploadImage(_image).then((value) => imageUrl = value);
                      final complaint = Complaint(
                        owner: auth.currentUser!.email,
                        image: imageUrl,
                        location: locationController.text.trim(),
                        status: 'lost',
                        description: descriptionController.text.trim(),
                        latitude: widget.latlong.latitude,
                        longitude: widget.latlong.longitude,
                        dateTime: lostDate ?? DateTime.now(),
                        finders: [],
                      );
                      // var emailController;
                      final docRef = db
                          .collection("complaints")
                          .withConverter(
                            fromFirestore: Complaint.fromFirestore,
                            toFirestore: (Complaint complaint, options) =>
                                complaint.toFirestore(),
                          )
                          .doc();
                      await docRef.set(complaint);

                      // Navigator.push(context,
                      //   MaterialPageRoute(builder: (ctx) => ItemScreen()));
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
