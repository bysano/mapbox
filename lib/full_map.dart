import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'location_helper.dart';
import 'main.dart';

class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
 late MapboxMapController mapController;
  Position? currentPosition;

  @override
  void initState() {
    super.initState();

  }


  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    LocationHelper.determinePosition().then((value) {
      mapController.moveCamera(
        CameraUpdate.newLatLng(
          LatLng(value.latitude, value.longitude),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MapboxMap(
      accessToken: MyApp.ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      initialCameraPosition:  CameraPosition(target: LatLng(currentPosition?.latitude ?? 22.45 , currentPosition?.longitude ?? 52.45), zoom: 6),
      onStyleLoadedCallback: onStyleLoadedCallback,
    ));
  }

  void onStyleLoadedCallback() {}
}
