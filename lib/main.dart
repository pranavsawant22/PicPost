import 'package:flutter/material.dart';
import 'package:quiz_app/helper/help.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signin.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  @override
  void initState() {
    checkuserstatus();
    // TODO: implement initState
    super.initState();
  }
 checkuserstatus() async{

    Helperfunction.checkuserinfo().then((value){
      isLoggedIn =  value;
    });
 }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (isLoggedIn ?? false)?Home(name:"User"):Signin(),
    );
  }
}

