import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'services/crud.dart';

class AddFood extends StatefulWidget{
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  String foodType;
  String location;

  QuerySnapshot food;

  crudMethods crudObj = new crudMethods();

  void addToList(String query, String foodtype) async{
    final addQuery = query;
    var addresses = await Geocoder.local.findAddressesFromQuery(addQuery);
    if(addresses.length != 0){
      var first = addresses.first;
      GeoPoint target = new GeoPoint(first.coordinates.latitude, first.coordinates.longitude);
      crudObj.addData({
        'FoodType': foodType,
        'Location': target
      });
      var feature = first.addressLine;
      print(first.thoroughfare);
      Fluttertoast.showToast(
        msg: "Added food at $feature",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIos: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
    else {
      Fluttertoast.showToast(
        msg: "Address not found...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Data', style: TextStyle(fontSize: 15.0)),
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter Food Type'),
                  onChanged: (value) {
                    this.foodType = value;
                  },
                ),
                SizedBox(height: 5.0),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter Location'),
                  onChanged: (value) {
                    this.location = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  addToList(this.location, this.foodType);
                },
              )
            ],
          );
        });
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Job Done', style: TextStyle(fontSize: 15.0)),
            content: Text('Added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState(){
    crudObj.getData().then((results) {
      setState(() {
        food = results;
      });
    });
    super.initState();
  }

  @override
  Widget build (BuildContext context){
     return new Scaffold(
        appBar: AppBar(
          title: Text('Add sum food to share'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                addDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                crudObj.getData().then((results) {
                  setState(() {
                    food = results;
                  });
                });
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: _foodList()
            ),
          ],
        ),
     );
  }

  Widget _foodList(){
    if (food != null) {
      return ListView.builder(
        itemCount: food.documents.length,
        padding: EdgeInsets.all(5.0),
        itemBuilder: (context, i) {
          return new ListTile(
            title: Text(food.documents[i].data['FoodType']),
            subtitle: Text(food.documents[i].data['Location'].latitude.toString()),
          );
        }
      );
    }
    else {
      return Text('Loading...');
    }
  }
}