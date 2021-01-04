import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
class Crudmethods{
  Future<void> addData(PostData) async{
    Firestore.instance.collection("Posts").add(PostData).catchError((e){
      print(e);
    });
  }
  getdata() async{
    return await Firestore.instance.collection("Posts").snapshots();
  }
}