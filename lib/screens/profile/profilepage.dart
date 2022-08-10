// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Profilepage extends StatelessWidget {
  Profilepage({Key? key}) : super(key: key);

  File? _image;

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

  @override
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
                child: _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                    : const Text('Photo'),
                radius: 80,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FloatingActionButton(
                  child: Icon(Icons.add_a_photo_outlined),
                  onPressed: _openImagePicker),
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
               
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text('Phone No'),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text('Email'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
