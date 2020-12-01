import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vunh_car/view/ride_picker.dart';

import 'home_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(10.7931944, 106.7046902),
                zoom: 14
              )
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      "Vunh Car",
                      style: TextStyle(fontSize: 20, color: Colors.deepPurpleAccent, ),
                    ),
                    leading: FlatButton(
                      onPressed: () {
                        print("Click menu");
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Icon(Icons.menu, color: Colors.deepPurpleAccent,)
                    ),
                    actions: <Widget>[Icon(Icons.notifications, color: Colors.deepPurpleAccent,)],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: RidePicker(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child:  HomeMenu(),
      )
    );
  }

}