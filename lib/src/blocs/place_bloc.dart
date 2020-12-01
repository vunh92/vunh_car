import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vunh_car/service/place_service.dart';

class PlaceBloc {
  var _placeController = StreamController();

  Stream get placeStream => _placeController.stream;

  void searchPlace(String keyword) {
    _placeController.sink.add("start");
    PlaceService.searchPlace(keyword).then((value){
      _placeController.sink.add(value);
    }).catchError((){
      // _placeController.sink.add("stop");
    });
  }

  void dispose() {
    _placeController.close();
  }
}