import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/add_food.dart';
import 'package:share_sum_food/pages/map_page.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
 int _currentIndex = 1;
 final List<Widget> _children = [
   AddFood(),
   MapPage(),
   AddFood(),
 ];

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: _children[_currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped,
       currentIndex: _currentIndex,
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.list),
           title: new Text('List'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.map),
           title: new Text('Map'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.settings),
           title: Text('Settings')
         )
       ],
     ),
   );
 }

 void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}