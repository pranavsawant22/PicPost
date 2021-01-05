import 'package:cloud_firestore/cloud_firestore.dart';
class Crudmethods{
  Future<void> addData(PostData) async{
    await Firestore.instance.collection("Posts").add(PostData).catchError((e){
      print(e);
    });
  }
  getdata() async{
    return await Firestore.instance.collection("Posts").orderBy("created",descending: true).snapshots();
  }
}