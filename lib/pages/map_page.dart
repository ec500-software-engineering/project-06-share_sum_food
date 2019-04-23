import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  @override
  State createState() => new MapPageState();
}

class MapPageState extends State with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: Text("Map Placeholder",
              style: TextStyle(fontSize: 25.0))),
    );
  }
}