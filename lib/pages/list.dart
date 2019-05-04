import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_sum_food/pages/home.dart';

class List extends StatelessWidget {
  
  Widget _buildListItem(BuildContext context, DocumentSnapshot doc) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              doc['FoodType'],
            ),
          ),
        Container(
          child: Text(
            doc['Location'].toString(),
          ),
          ),
        ],
      ),
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: StreamBuilder(
              stream: Firestore.instance.collection('food').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                itemExtent: 70.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
                  );
              }),
          ),

        ],
      ),
      );
  }
}

