import 'package:cloud_firestore/cloud_firestore.dart';


class crudMethods {

  Future<void> addData(foodData) async {
    Firestore.instance.collection('food').add(foodData).catchError((e) {
      print(e);
    });
  }
}