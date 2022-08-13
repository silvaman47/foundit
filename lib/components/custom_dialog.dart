// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key, required this.content, required this.onPressed}) : super(key: key);
  final String content;
  final Function() onPressed;
  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Alert'),
      content: Text(widget.content),
      actions: [TextButton(onPressed: widget.onPressed, child: Text('OK'))],
    );
  }
}
