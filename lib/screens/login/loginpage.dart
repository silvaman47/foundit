// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:developer';

import 'package:email_validator/email_validator.dart';
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
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        AbsorbPointer(
          absorbing: isLoading,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Column(children: <Widget>[
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            child: IconButton(
                                onPressed: null,
                                icon: Icon(Icons.arrow_back_ios)),
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
                        children: <Widget>[],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          onChanged: (val) {
                            validateEmail(val);
                          },
                          validator: (String? value) {
                            return (value == null || !value.contains('@'))
                                ? 'enter valid email'
                                : null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          controller: passwordController,
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
                        height: 40,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Center(
                            child: InkWell(
                          child: Text('Login'),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              setState(() {
                                isLoading = true;
                              });
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
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => Homepage()),
                                  (route) => false);
                            }
                          },
                        )),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ]),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }

  void validateEmail(String val) {
    if (val.isEmpty && !val.contains('@')) {
      setState(() {
        _errorMessage = "Email can not be empty or invalid";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}
