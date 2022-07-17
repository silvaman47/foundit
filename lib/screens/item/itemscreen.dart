// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foundit/models/complain_model.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  String name = '';
  List<Complaint> demoComplaints = [
Complaint(description: 'Blue Bag', finders: [], latitude: 2.333, longitude: -54.66,status: 'expired',user: 'Silas',time: '12.00',image: 'assets/images/appsplash.png'),
Complaint(description: 'Blue Bag', finders: [], latitude: 2.333, longitude: -54.66,status: 'expired',user: 'Silas',time: '12.00',image: 'assets/images/appsplash.png'),
Complaint(description: 'Blue Bag', finders: [], latitude: 2.333, longitude: -54.66,status: 'expired',user: 'Silas',time: '12.00',image: 'assets/images/appsplash.png'),
Complaint(description: 'Blue Bag', finders: [], latitude: 2.333, longitude: -54.66,status: 'expired',user: 'Silas',time: '12.00',image: 'assets/images/appsplash.png'),
Complaint(description: 'Blue Bag', finders: [], latitude: 2.333, longitude: -54.66,status: 'expired',user: 'Silas',time: '12.00',image: 'assets/images/appsplash.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NEW'),),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // ignore: prefer_const_constructors
          ...List.generate(demoComplaints.length, (index) => ListTile(
            
            )
            )
        ],
      )),
    );
  }
}
