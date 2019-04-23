import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  @override
  State createState() => new MapPageState();
}

class MapPageState extends State with TickerProviderStateMixin {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kPhotonics = CameraPosition(
    target: LatLng(42.349265, -71.1066452),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kPhotonics,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}