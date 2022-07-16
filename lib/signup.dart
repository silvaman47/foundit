// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:foundit/loginpage.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

//  TextEditingController emailController = new TextEditingController();
  //TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                Container(
                  margin: EdgeInsets.only(top: 10, left: 50, right: 10),
                  height: 60,
                  width: 400,
                  child: Center(child: Text('Create Account')),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
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
                        child: Text('Login In'),
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
