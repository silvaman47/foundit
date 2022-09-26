// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:foundit/constants/custom_textstyle.dart';
import 'package:foundit/models/complain_model.dart';
import 'package:foundit/screens/home/homepage.dart';
import 'package:intl/intl.dart';
import 'package:foundit/models/user_model.dart';

class ItemDescriptionPage extends StatefulWidget {
  const ItemDescriptionPage({Key? key, required this.lostItem})
      : super(key: key);
  final dynamic lostItem;
  @override
  State<ItemDescriptionPage> createState() => _ItemDescriptioPageState();
}

class _ItemDescriptioPageState extends State<ItemDescriptionPage> {
  String? formattedDate;

  final db = FirebaseFirestore.instance.collection('complaints');

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: customtextstyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    //  shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  height: 200,
                  width: 400,
                  child: FittedBox(
                    child: Image(
                      height: 200,
                      width: 400,
                      image: NetworkImage(widget.lostItem["image"]),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.lostItem["location"],
                  style: customtext(),
                ),
                height: 100,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                margin: EdgeInsets.only(right: 70),
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.lostItem["owner"],
                  style: customtext(),
                ),
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.80,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                margin: EdgeInsets.only(right: 70),
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.lostItem["description"],
                  style: customtext(),
                ),
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.80,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.80,
                margin: EdgeInsets.only(right: 70),
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  DateFormat('yyyy-MM-dd').format(Timestamp(
                          widget.lostItem['dateTime'].seconds,
                          widget.lostItem['dateTime'].nanoseconds)
                      .toDate()),
                  style: customtext(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                margin: EdgeInsets.only(right: 70),
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.lostItem["ownernum"],
                  style: customtext(),
                ),
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.80,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text("Alert"),
                          content:
                              Text("Do you want to confirm claim of this item"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await db
                                    .doc(widget.lostItem.id)
                                    .update({"status": 'found'});
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          Homepage()),
                                  ModalRoute.withName('/'),
                                );
                              },
                              child: Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No"),
                            ),
                          ],
                        ));
              },
              child: Text('Claim'),
            )
          ],
        ),
      ),
    );
  }

  TextStyle customtext() {
    return TextStyle(
        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 20);
  }
}
