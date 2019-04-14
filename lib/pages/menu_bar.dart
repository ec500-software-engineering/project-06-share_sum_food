import 'package:flutter/material.dart';

class bottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _widgetOptions = [
      Text('Index 0: Home'),
      Text('Index 1: List'),
      Text('Index 2: Settings'),
    ];

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: new Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
            icon: new Icon(Icons.list), title: Text('List')),
        BottomNavigationBarItem(
            icon: new Icon(Icons.settings), title: Text('Settings')),
      ],
//    currentIndex: _selectedIndex,
    );
  }
}
