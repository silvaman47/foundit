// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/components/custom_dialog.dart';
import 'package:foundit/models/user_model.dart';
import 'package:foundit/screens/home/homepage.dart';
import 'package:foundit/screens/login/loginpage.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      child: IconButton(
                          onPressed: null, icon: Icon(Icons.arrow_back_ios)),
                    ),
                  ],
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
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 50),
                      child: Text(
                        'Your Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 50, right: 10),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    key: key,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 50),
                      child: Text(
                        'Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 50, right: 10),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    key: key,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      // Create a new user with a first and last name

                      auth.createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => Homepage()));
                      //
                      final user = UserModel(
                        name: '',
                        image: '',
                        location: '',
                        complaints: [],
                      );
                      final docRef = db
                          .collection("users")
                          .withConverter(
                            fromFirestore: UserModel.fromFirestore,
                            toFirestore: (UserModel user, options) =>
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
                    margin: EdgeInsets.only(top: 10, left: 50, right: 10),
                    height: 60,
                    width: 400,
                    child: Center(child: Text('Create Account')),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 50, right: 10),
                  height: 60,
                  width: 400,
                  child: Center(child: Text('Sign up with Google')),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(
                  height: 50,
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
                        child: Text('LogIn'),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
