import 'package:flutter/material.dart';

class HomeMenu extends StatefulWidget {
  @override
  HomeMenuState createState() {
    return HomeMenuState();
  }
}

class HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle, color: Colors.blueGrey),
          title: Text(
            "My Profile",
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ),
        ListTile(
          leading: Icon(Icons.history, color: Colors.blueGrey),
          title: Text(
            "Ride History",
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ),
        ListTile(
          leading: Icon(Icons.notifications, color: Colors.blueGrey),
          title: Text(
            "Notifications",
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ),
      ],
    );
  }

}