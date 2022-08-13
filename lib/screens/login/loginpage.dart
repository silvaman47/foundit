// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/components/custom_dialog.dart';
import 'package:foundit/screens/home/homepage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Column(children: <Widget>[
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
                      'Login',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
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
                child: Center(
                    child: InkWell(
                  child: Text('Login'),
                  onTap: () {
                    try {
                      auth.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text);
                    } on FirebaseAuthException catch (e) {
                      log(e.toString());
                      CustomDialog(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          content: e.toString());
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ),
                    );
                  },
                )),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ]),
          ]),
    ));
  }
}
