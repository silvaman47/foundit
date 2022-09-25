// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foundit/constants/custom_textstyle.dart';
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
        ownernum: '0540484607',
        latitude: 2.333,
        longitude: -54.66,
        status: 'expired',
        idowner: 'Silas',
        dateTime: DateTime(2022, 9, 8, 1, 30),
        image: 'assets/images/appsplash.png',
        location: 'KUST SCHOOL PATRK'),
    Complaint(
        description: 'Blue Bag',
        ownernum: '0540484607',
        latitude: 2.333,
        longitude: -54.66,
        status: 'expired',
        idowner: 'Silas',
        dateTime: DateTime(2022, 9, 8, 1, 30),
        image: 'assets/images/appsplash.png',
        location: 'KUST SCHOOL PATRK'),
    Complaint(
        description: 'Blue Bag',
        ownernum: '0540484607',
        latitude: 2.333,
        longitude: -54.66,
        status: 'expired',
        idowner: 'Silas',
        dateTime: DateTime(2022, 9, 8, 1, 30),
        image: 'assets/images/appsplash.png',
        location: 'KUST SCHOOL PATRK'),
    Complaint(
        description: 'Blue Bag',
        ownernum: '0540484607',
        latitude: 2.333,
        longitude: -54.66,
        status: 'expired',
        idowner: 'Silas',
        dateTime: DateTime(2022, 9, 8, 1, 30),
        image: 'assets/images/appsplash.png',
        location: 'KUST SCHOOL PATRK'),
    Complaint(
        description: 'Blue Bag',
        ownernum: '0540484607',
        latitude: 2.333,
        longitude: -54.66,
        status: 'expired',
        idowner: 'Silas',
        dateTime: DateTime(2022, 9, 8, 1, 30),
        image: 'assets/images/appsplash.png',
        location: 'KUST SCHOOL PATRK'),
  ];

  final Stream<QuerySnapshot> _complaintStream = FirebaseFirestore.instance
      .collection('complaints')
      .where("status", isEqualTo: 'lost')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Lost Items',
            style: customtextstyle(),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _complaintStream,
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return LostItemCard(lostItem: snapshot.data!.docs[index]);
                });
            // SingleChildScrollView(
            //   child: Column(
            //     children: snapshot.data!.docs
            //         .map((DocumentSnapshot document) {
            //           // Map<String, dynamic> data =
            //           //     document as Map<String, dynamic>;
            //           return LostItemCard(lostItem: document.data);
            //         })
            //         .toList()
            //         .cast(),
            //     // [
            //   ...List.generate(
            //     demoComplaints.length,
            //     (index) => LostItemCard(lostItem: demoComplaints[index]),
            //   ),
            // ],
          }),
        ));
  }
}
