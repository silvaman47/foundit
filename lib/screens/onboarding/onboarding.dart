// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:foundit/screens/complain/profile/signup/signup.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../signup/signup.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => SafeArea(
        // ignore: duplicate_ignore
        child: IntroductionScreen(
          showNextButton: false,
          pages: [
            PageViewModel(
              title: 'Save your self time and effort',
              body: 'Searchinng for lost items has never been easier',
              image: buildImage('assets/images/onboard1.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Save your self time and effort',
              body: 'Searchinng for lost items has never been easier',
              image: buildImage('assets/images/onboard1.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Save your self time and effort',
              body: 'Searchinng for lost items has never been easier',
              image: buildImage('assets/images/onboard1.jpg'),
              decoration: getPageDecoration(),
            ),
          ],
          // ignore: prefer_const_constructors
          done: Text(
            'Start',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onDone: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const Signup())
            );
          },
        ),
      );
}

Widget buildImage(String path) => Center(
      child: Image.asset(
        path,
        width: 350,
      ),
    );

PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    bodyTextStyle: TextStyle(fontSize: 20),
    //descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
    imagePadding: EdgeInsets.all(24),
    pageColor: Colors.white);
