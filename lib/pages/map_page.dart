import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  @override
  State createState() => new MapPageState();
}

class MapPageState extends State with TickerProviderStateMixin {
  
  GoogleMapController mapController;
  var currentLocation;
  bool mapToggle = false;

  
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
  }

  static final CameraPosition _kPhotonics = CameraPosition(
    target: LatLng(42, -71.1066452),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    body: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 60.0,
              width: double.infinity,
              child: mapToggle ?
              GoogleMap(
                onMapCreated: onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(currentLocation.latitude, currentLocation.longitude),
                  zoom: 14.0,
                ),
              ):
              Center(child:
              Text('Loading map...',
              style: TextStyle(
                fontSize: 20.0
              ))),
            )
          ],
        )
      ],
    )
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}