import 'package:flutter/material.dart';
import 'package:foundit/screens/onboarding/onboarding.dart';

void main() {
  runApp(const Foundit());
}

class Foundit extends StatelessWidget {
  const Foundit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Onboarding(),
    );
  }
}
