// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';
import 'package:foundit/screens/item_screen/component/item_description.dart';
import 'package:intl/intl.dart';
import '../../../models/complain_model.dart';

class LostItemCard extends StatefulWidget {
  const LostItemCard({Key? key, required this.lostItem}) : super(key: key);
  final dynamic lostItem;

  @override
  State<LostItemCard> createState() => _LostItemCardState();
}

class _LostItemCardState extends State<LostItemCard> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  //final en_Format = DateTime.now().toIso8601String();
  // print("EN (Format): $en_Format");

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) =>
                      ItemDescriptionPage(lostItem: widget.lostItem)));
        },
        leading: Container(
            width: 80,
            height: 80,
            child: widget.lostItem['image'] != null
                ? Image.network('${widget.lostItem['image']}')
                : Image.network(
                    "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png")),
        title: Text(widget.lostItem['location']),
        subtitle: Text(DateFormat('yyyy-MM-dd').format(Timestamp(
                widget.lostItem['dateTime'].seconds,
                widget.lostItem['dateTime'].nanoseconds)
            .toDate())));
  }
}
