import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  State createState() => new MapPageState();
}

class MapPageState extends State with TickerProviderStateMixin {

  //google map stuff 
  GoogleMapController mapController;
  var currentLocation;
  bool mapToggle = false;

  List<Marker> foodMarkers = [];

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
    populateFood();
  }

  //read all food entries in db, turn them into markers
  populateFood(){
    foodMarkers = [];
    Firestore.instance.collection('food').getDocuments().then((food) {
    if(food.documents.isNotEmpty) {
      for(int i = 0; i < food.documents.length; ++i){
        print(food.documents[i].data['FoodType']);
        foodMarkers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(food.documents[i].data['Location'].latitude, food.documents[i].data['Location'].longitude),
          infoWindow: InfoWindow(title: food.documents[i].data['FoodType']),
        ));
      }
    }
    });
  }


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
                markers: Set.from(foodMarkers),
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