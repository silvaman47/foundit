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
      floatingActionButton: FloatingActionButton(
        onPressed: (() {}),
        child: Icon(Icons.message),
      ),
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
              child: Image(image: NetworkImage(widget.lostItem["image"]))),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 200, 10),
            child: Text(widget.lostItem["location"]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(right: 70),
            padding: EdgeInsets.fromLTRB(10, 10, 200, 10),
            child: Text(widget.lostItem["owner"]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(right: 70),
            padding: EdgeInsets.fromLTRB(10, 10, 200, 10),
            child: Text(widget.lostItem["description"]),
          ),
          Container(
            margin: EdgeInsets.only(right: 70),
            padding: EdgeInsets.fromLTRB(10, 10, 200, 10),
            child: Text(DateFormat('yyyy-MM-dd').format(Timestamp(
                    widget.lostItem['dateTime'].seconds,
                    widget.lostItem['dateTime'].nanoseconds)
                .toDate())),
          )
        ],
      ),
    );
  }
}
