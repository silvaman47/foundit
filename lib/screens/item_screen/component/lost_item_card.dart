// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';
import 'package:foundit/screens/item_screen/component/item_description.dart';
import '../../../models/complain_model.dart';

class LostItemCard extends StatefulWidget {
  const LostItemCard({Key? key, required this.lostItem}) : super(key: key);
  final Complaint lostItem;
  @override
  State<LostItemCard> createState() => _LostItemCardState();
}

class _LostItemCardState extends State<LostItemCard> {
  String? formattedDate;
  @override
  void initState() {
    // TODO: implement initState
    formattedDate = widget.lostItem.dateTime!.format('MMMM dd y, h:mm:ss a');
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
        child: Image(
          image: AssetImage(widget.lostItem.image!),
        ),
      ),
      title: Text(widget.lostItem.location!),
      subtitle: Text(formattedDate!),
    );
  }
}
