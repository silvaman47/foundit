// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foundit/homepage.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({Key? key}) : super(key: key);

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
                child: Center(
                  child: InkWell(
                    child: Text('Login'),
                    onTap: (){
                           Navigator.push(context, MaterialPageRoute(
                           builder: (context) => const Homepage(),
                           ),
                      );
                        },)
                    ),
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
