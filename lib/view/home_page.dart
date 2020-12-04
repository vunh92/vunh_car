import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vunh_car/service/place_service.dart';
import 'package:vunh_car/src/model/place_item_res.dart';
import 'package:vunh_car/view/ride_picker.dart';

import 'home_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _tripDistance = 0;
  final Map<String, Marker> _markers = <String, Marker>{};

  GoogleMapController _mapController;

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
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(10.7931944, 106.7046902),
                zoom: 14
              ),
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
                    child: RidePicker(onPlaceSelected),
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

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
    _addMarker(mkId, place);
    _moveCamera();
    // _checkDrawPolyline();
  }

  void _addMarker(String mkId, PlaceItemRes place) async {
    // remove old
    _markers.remove(mkId);
    // _mapController.clearMarkers();

    /*_markers[mkId] = Marker(
        mkId,
        MarkerOptions(
            position: LatLng(place.lat, place.lng),
            infoWindowText: InfoWindowText(place.name, place.address)));*/

    // _markers[mkId] = Marker(markerId: new MarkerId(place.name));
    // final icon = await BitmapDescriptor.fromAsset("assets/ic_location_black.png");
    _markers[mkId] = Marker(
        markerId:MarkerId(place.name),
        position: LatLng(place.lat, place.lng) ,
        infoWindow: InfoWindow(title: mkId, snippet: '*'),
        icon: BitmapDescriptor.fromAsset("assets/ic_location_black.png"),
        // icon: icon,
    );
    for (var m in _markers.values) {
      // await _mapController.addMarker(m.options);
      await _mapController.moveCamera(CameraUpdate.newLatLng(m.position));
    }
  }

  void _moveCamera() {
    print("move camera: ");
    print(_markers);

    if (_markers.values.length > 1) {
      var fromLatLng = _markers["from_address"].position;
      var toLatLng = _markers["to_address"].position;

      // PlaceItemRes fromLatLng = new PlaceItemRes("Trường Sa", "1024 Trường Sa, Bình Thạnh, HCM", 10.794088, 106.699474);
      // PlaceItemRes toLatLng = new PlaceItemRes("Hoàng Sa", "10 Hoàng Sa, Bình Thạnh, HCM", 10.794080, 106.699470);

      var sLat, sLng, nLat, nLng;
      if(fromLatLng.latitude <= toLatLng.latitude) {
        sLat = fromLatLng.latitude;
        nLat = toLatLng.latitude;
      } else {
        sLat = toLatLng.latitude;
        nLat = fromLatLng.latitude;
      }

      if(fromLatLng.longitude <= toLatLng.longitude) {
        sLng = fromLatLng.longitude;
        nLng = toLatLng.longitude;
      } else {
        sLng = toLatLng.longitude;
        nLng = fromLatLng.longitude;
      }

      LatLngBounds bounds = LatLngBounds(northeast: LatLng(nLat, nLng), southwest: LatLng(sLat, sLng));
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      _mapController.animateCamera(CameraUpdate.newLatLng(_markers.values.elementAt(0).position));
    }
  }

  void _checkDrawPolyline() {
//  remove old polyline
//     _mapController.clearPolylines();

    if (_markers.length > 1) {
      // var from = _markers["from_address"].options.position;
      // var to = _markers["to_address"].options.position;
      LatLng from = new LatLng(0, 0);
      LatLng to = new LatLng(0, 1);
      PlaceService.getStep(
          from.latitude, from.longitude, to.latitude, to.longitude)
          .then((vl) {
        TripInfoRes infoRes = vl;

        _tripDistance = infoRes.distance;
        setState(() {
        });
        List<StepsRes> rs = infoRes.steps;
        List<LatLng> paths = new List();
        for (var t in rs) {
          paths
              .add(LatLng(t.startLocation.latitude, t.startLocation.longitude));
          paths.add(LatLng(t.endLocation.latitude, t.endLocation.longitude));
        }

//        print(paths); vẽ đường đi
        /*_mapController.addPolyline(PolylineOptions(
            points: paths, color: Color(0xFF3ADF00).value, width: 10));*/
      });
    }
  }

}