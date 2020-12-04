import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vunh_car/src/model/place_item_res.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceService {
  static final String apiKey = "AIzaSyA4iajiV1FZQcjvC1mt7Rw1gzc16VI3ZGk";
  static Future<List<PlaceItemRes>> searchPlace (String keyword) async {
   /* String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
                apiKey +
                "&language=vi&region=VN&query=" +
                Uri.encodeQueryComponent(keyword);*/

    String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyA4iajiV1FZQcjvC1mt7Rw1gzc16VI3ZGk&language=vi&region=VN&query=30trannao";
    var res = await http.get(url);
    if(res.statusCode == 200) {
      return PlaceItemRes.fromJson(json.decode(res.body));
    }else {
      return new List();
    }
  }
  // 10.794088, 106.699474  - Trường Sa
  // 10.792555, 106.699366  - Hoàng Sa
//https://maps.googleapis.com/maps/api/place/findplacefromtext/output?parameters
//https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyA4iajiV1FZQcjvC1mt7Rw1gzc16VI3ZGk&language=vi&region=VN&query=30trannao

//https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&formatted_address,name,rating,opening_hours,geometry&key=AIzaSyA4iajiV1FZQcjvC1mt7Rw1gzc16VI3ZGk

  static Future<dynamic> getStep(
      double lat, double lng, double tolat, double tolng) async {
    String str_origin = "origin=" + lat.toString() + "," + lng.toString();
    // Destination of route
    String str_dest =
        "destination=" + tolat.toString() + "," + tolng.toString();
    // Sensor enabled
    String sensor = "sensor=false";
    String mode = "mode=driving";
    // Building the parameters to the web service
    String parameters = str_origin + "&" + str_dest + "&" + sensor + "&" + mode;
    // Output format
    String output = "json";
    // Building the url to the web service
    String url = "https://maps.googleapis.com/maps/api/directions/" +
        output +
        "?" +
        parameters +
        "&key=" +
        apiKey;

    print(url);
    final JsonDecoder _decoder = new JsonDecoder();
    return http.get(url).then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
//      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" +
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception(res);
      }


      TripInfoRes tripInfoRes;
      try {
        var json = _decoder.convert(res);
        int distance = json["routes"][0]["legs"][0]["distance"]["value"];
        List<StepsRes> steps =
        _parseSteps(json["routes"][0]["legs"][0]["steps"]);

        tripInfoRes = new TripInfoRes(distance, steps);

      } catch (e) {
        throw new Exception(res);
      }

      return tripInfoRes;
    });
  }

  static List<StepsRes> _parseSteps(final responseBody) {
    var list = responseBody
        .map<StepsRes>((json) => new StepsRes.fromJson(json))
        .toList();

    return list;
  }
}

class TripInfoRes {
  final int distance; // met
  final List<StepsRes> steps;

  TripInfoRes(this.distance, this.steps);
}

class StepsRes {
  LatLng startLocation;
  LatLng endLocation;
  StepsRes({this.startLocation, this.endLocation});
//  Steps();
  factory StepsRes.fromJson(Map<String, dynamic> json) {
    return new StepsRes(
        startLocation: new LatLng(
            json["start_location"]["lat"], json["start_location"]["lng"]),
        endLocation: new LatLng(
            json["end_location"]["lat"], json["end_location"]["lng"]));
  }
}
