// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:foundit/models/complain_model.dart';
import 'package:intl/intl.dart';

class ItemDescriptionPage extends StatefulWidget {
  const ItemDescriptionPage({Key? key, required this.lostItem})
      : super(key: key);
  final dynamic lostItem;
  @override
  State<ItemDescriptionPage> createState() => _ItemDescriptioPageState();
}

class _ItemDescriptioPageState extends State<ItemDescriptionPage> {
  String? formattedDate;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        children: [
          Container(
              child: Image(image: NetworkImage(widget.lostItem["image"]))),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(widget.lostItem["location"]),
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(right: 70),
            padding: EdgeInsets.only(left: 10),
            child: Text(widget.lostItem["owner"]),
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(right: 70),
            padding: EdgeInsets.only(left: 10),
            child: Text(widget.lostItem["description"]),
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: 70),
            padding: EdgeInsets.only(left: 10),
            child: Text(DateFormat('yyyy-MM-dd').format(Timestamp(
                    widget.lostItem['dateTime'].seconds,
                    widget.lostItem['dateTime'].nanoseconds)
                .toDate())),
          ),
          SizedBox(
            height: 80,
          ),
          TextButton(
            onPressed: () {},
            child: Text('Claim'),
          )
        ],
      ),
    );
  }
}
