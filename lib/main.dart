import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foundit/screens/home/homepage.dart';
import 'package:foundit/screens/onboarding/onboarding.dart';
import 'package:foundit/screens/signup/signup.dart';

Widget defaultRoute = const Homepage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Foundit());

  checkSignIn() {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      defaultRoute = const Onboarding();
    } else {
      defaultRoute = defaultRoute;
    }
  }

  checkSignIn();
}

class Foundit extends StatelessWidget {
  const Foundit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: defaultRoute,
    );
  }
}
