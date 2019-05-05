import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/add_food.dart';
import 'package:share_sum_food/pages/map_page.dart';
import 'package:share_sum_food/pages/options.dart';

class Home extends StatefulWidget {
  final bool isSeeker;
  const Home({@required this.isSeeker});
 @override
 State<StatefulWidget> createState() {
    return _HomeState(isSeeker);
  }
}

class _HomeState extends State<Home> {
  static bool IsSeeker;
  _HomeState(bool _isSeeker){
      IsSeeker = _isSeeker;
      print(IsSeeker);
  }

 int _currentIndex = 1;


 @override
 Widget build(BuildContext context) {
   print("IN HOME  " + IsSeeker.toString());
   List<Widget> _children = [
     AddFood(isSeeker: IsSeeker),
     MapPage(),
     Options(),
   ];
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
           title: Text('Options')
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