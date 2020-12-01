import 'package:flutter/material.dart';

class OtherFunctions extends StatefulWidget {
  @override
  _OtherFunctions createState() => _OtherFunctions();

}

class _OtherFunctions extends State<OtherFunctions> {
  bool viewTextVisible = true;
  String textBt = "show";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.deepPurple),
        elevation: 0,
        title: Text(
          "Other Functions",
          style: TextStyle(fontSize: 20, color: Colors.deepPurple, ),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _onShowHideClicked,
                  child: Text(
                    textBt,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  color: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                ),
              ),
              viewTextVisible ? new Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewTextVisible,
                  child: Container(
                      height: 50,
                      width: 200,
                      color: Colors.green,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(child: Text('Show/Hide Text View',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,
                              fontSize: 23)))
                  )
              ): new Container(),
              Text("@@@@@@@@@@@@@@")
            ],
          ),
        ),
      ),
    );
  }

  _onShowHideClicked() {
    setState(() { //setState load lại view
      viewTextVisible = !viewTextVisible;
      textBt = viewTextVisible ? "Hide":"Show";
    });
  }

}