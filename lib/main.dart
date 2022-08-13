import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foundit/screens/onboarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
