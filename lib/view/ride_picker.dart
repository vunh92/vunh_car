import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vunh_car/src/blocs/place_bloc.dart';
import 'package:vunh_car/src/model/place_item_res.dart';

class RidePicker extends StatefulWidget {
  @override
  RidePickerState createState() => RidePickerState();
}

class RidePickerState extends State<RidePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurpleAccent,
            offset: Offset(0,5),
            blurRadius: 5.0,
        )]
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RidePickerPage(),)
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 50,
                        child: Icon(Icons.location_on, color: Colors.red,),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        width: 40,
                        height: 50,
                        child: Icon(Icons.close, color: Colors.black,),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 50, 0),
                        child: Text(
                          "Trường Sa, HCM",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
                onPressed: (){},
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 50,
                        child: Icon(Icons.send, color: Colors.deepPurpleAccent,),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        width: 40,
                        height: 50,
                        child: Icon(Icons.close, color: Colors.black,),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 50, 0),
                        child: Text(
                          "Home",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}

class RidePickerPage extends StatefulWidget {
  @override
  RidePickerPageState createState() => RidePickerPageState();
}

class RidePickerPageState extends State<RidePickerPage> {
  var _addressController;
  PlaceBloc placeBloc = new PlaceBloc();

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    placeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xfff8f8f8),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 60,
                        child: Icon(Icons.location_on, color: Colors.red,),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        width: 40,
                        height: 60,
                        child: FlatButton(
                            onPressed: (){
                              _addressController.text = "";
                            },
                            child: Icon(Icons.clear, color: Colors.black45,)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 50),
                        child: TextField(
                          controller: _addressController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            placeBloc.searchPlace(value);
                          },
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: StreamBuilder(
                stream: placeBloc.placeStream,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    if(snapshot.data == "start"){
                      return Center(
                          child: CircularProgressIndicator(),
                      );
                    }

                    List<PlaceItemRes> places = snapshot.data;
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(places.elementAt(index).name),
                            subtitle: Text(places.elementAt(index).address),
                            onTap: (){
                              print("ontap " + index.toString());
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: Colors.black12,
                        ),
                        itemCount: places.length
                    );
                  }else{
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}
