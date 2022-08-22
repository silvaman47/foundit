// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foundit/models/complain_model.dart';
import 'package:foundit/screens/item_screen/component/lost_item_card.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  String name = '';
  List<Complaint> demoComplaints = [
    Complaint(
        description: 'Blue Bag',
        finders: [],
        latitude: 2.333,
        longitude: -54.66,
        status: 'expired',
        owner: 'Silas',
        dateTime: DateTime(2022, 9, 8, 1, 30),
        image: 'assets/images/appsplash.png',
        location: 'KUST SCHOOL PATRK'),
    Complaint(
        description: 'Blue Bag',
        finders: [],
        latitude: 2.333,
        longitude: -54.66,
        status: 'expired',
        owner: 'Silas',
        dateTime: DateTime(2022, 9, 8, 1, 30),
        image: 'assets/images/appsplash.png',
        location: 'KUST SCHOOL PATRK'),
    Complaint(
        description: 'Blue Bag',
        finders: [],
        latitude: 2.333,
        longitude: -54.66,
        status: 'expired',
        owner: 'Silas',
        dateTime: DateTime(2022, 9, 8, 1, 30),
        image: 'assets/images/appsplash.png',
        location: 'KUST SCHOOL PATRK'),
    Complaint(
        description: 'Blue Bag',
        finders: [],
        latitude: 2.333,
        longitude: -54.66,
        status: 'expired',
        owner: 'Silas',
        dateTime: DateTime(2022, 9, 8, 1, 30),
        image: 'assets/images/appsplash.png',
        location: 'KUST SCHOOL PATRK'),
    Complaint(
        description: 'Blue Bag',
        finders: [],
        latitude: 2.333,
        longitude: -54.66,
        status: 'expired',
        owner: 'Silas',
        dateTime: DateTime(2022, 9, 8, 1, 30),
        image: 'assets/images/appsplash.png',
        location: 'KUST SCHOOL PATRK'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lost Items'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ...List.generate(
            demoComplaints.length,
            (index) => LostItemCard(lostItem: demoComplaints[index]),
          ),
        ],
      )),
    );
  }
}
