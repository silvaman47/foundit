// ignore_for_file: prefer_const_constructors, duplicate_ignore, unnecessary_new, unused_import, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:foundit/screens/complain/complain_page.dart';
import 'package:foundit/screens/complain/profile/profilepage.dart';

import "package:http/http.dart" as http;
import "dart:convert" as convert;

import 'package:latlong2/latlong.dart';

import 'package:foundit/constants/custom_textstyle.dart';
import '../item_screen/itemscreen.dart';
import '../profile/profilepage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final String apiKey = "AK2MyelP411wH8oM1ulNVrAgbH1ROMv0";
  LatLng tomtomHQ = LatLng(6.6854, -1.5707);

  //get apiKey => null;
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FOUNDIT',
          style: customtextstyle(),
        ),
      ),
      body: Stack(children: <Widget>[
        FlutterMap(
          options: new MapOptions(
              center: tomtomHQ,
              zoom: 18.0,
              onTap: (value, newLat) {
                setState(() {
                  tomtomHQ = newLat;
                });
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Alert"),
                    content: Text("Lodge complain at this location?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      ComplainPage(latlong: tomtomHQ)));
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
                  ),
                );
              }),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                  "{z}/{x}/{y}.png?key={apiKey}",
              additionalOptions: {"apiKey": apiKey},
            ),
            new MarkerLayerOptions(markers: [
              new Marker(
                  width: 60,
                  height: 60,
                  point: tomtomHQ,
                  builder: (BuildContext context) {
                    print(tomtomHQ);
                    return Icon(
                      Icons.location_on,
                      size: 60,
                      color: Colors.black,
                    );
                  }),
            ]),
          ],
        ),
      ]),
    );
  }
}

class NavHome extends StatefulWidget {
  const NavHome({Key? key}) : super(key: key);

  @override
  State<NavHome> createState() => _NavHomeState();
}

class _NavHomeState extends State<NavHome> {
  final List _children = [
    Homepage(),
    ItemScreen(),
    EditProfile(),
  ];
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.map,
                color: Colors.black,
              ),
              label: 'Map',
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: 'Items',
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: 'Profile',
              backgroundColor: Colors.blueAccent,
            ),
          ]),
    );
  }
}
