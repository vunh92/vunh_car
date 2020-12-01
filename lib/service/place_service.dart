import 'dart:async';
import 'package:vunh_car/src/model/place_item_res.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceService {
  static Future<List<PlaceItemRes>> searchPlace (String keyword) async {
   /* String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
                "AIzaSyA4iajiV1FZQcjvC1mt7Rw1gzc16VI3ZGk" +
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
}
//https://maps.googleapis.com/maps/api/place/findplacefromtext/output?parameters
//https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyA4iajiV1FZQcjvC1mt7Rw1gzc16VI3ZGk&language=vi&region=VN&query=30trannao

//https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&formatted_address,name,rating,opening_hours,geometry&key=AIzaSyA4iajiV1FZQcjvC1mt7Rw1gzc16VI3ZGk
