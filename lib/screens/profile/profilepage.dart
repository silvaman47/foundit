// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

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
            Container(
              margin: EdgeInsets.only(bottom: 30),
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
                Container(
                  width: 290,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
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
                  child: Text('Number'),
                ),
                SizedBox(
                  width: 0,
                ),
                Container(
                  //margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.only(right: 20),
                  width: 290,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                    ),
                  ),
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 290,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
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
                  child: Text('About'),
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
