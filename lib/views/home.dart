
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/services/crud.dart';
import 'package:quiz_app/views/Post.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:toast/toast.dart';
class Home extends StatefulWidget {
  String name;
  Home({this.name});
  @override
  _HomeState createState() => _HomeState(name);
}


class _HomeState extends State<Home> {
  String name,name1;

  Crudmethods crudmethods = new Crudmethods();
  Stream poststream ;
Widget PostList(){
  return poststream!= null ? Container(
    child:StreamBuilder(
      stream: poststream,
      builder: (context,snapshot){
        return ListView.builder(
        itemCount: snapshot.data.documents.length,
  shrinkWrap: true,
  itemBuilder: (context,index){
  return BlogTile(
  url: snapshot.data.documents[index].data["url"],
  title: snapshot.data.documents[index].data["title"],
  desc: snapshot.data.documents[index].data["desc"],
  );
  }
  );
  },
    )
  ):Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
  _HomeState(this.name);

  @override
  void initState() {

    super.initState();
    crudmethods.getdata().then((results){
      setState(() {
        poststream = results;
      });



    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
          onTap: () {
            Toastmaker("Successfully Logged out!", context);
   FirebaseAuth.instance.signOut();
   Navigator.pushReplacement(context, MaterialPageRoute(
     builder: (context)=>Signin()
   )
   );
    },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.archive)),
          )
        ],
        shape: const MyShapeBorder(50),
        title: Text("\nHello ${name}!",style: TextStyle(
          fontSize: 30,
        ),),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 55),
          child: PostList()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        elevation: 0,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>CreatePost()
          ));
        },
      ),
    );

  }
}
class MyShapeBorder extends ContinuousRectangleBorder {
  const MyShapeBorder(this.curveHeight);
  final double curveHeight;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) => Path()
    ..lineTo(0, rect.size.height)
    ..quadraticBezierTo(
      rect.size.width / 2,
      rect.size.height + curveHeight * 2,
      rect.size.width,
      rect.size.height,
    )
    ..lineTo(rect.size.width, 0)
    ..close();
}
class BlogTile extends StatelessWidget {
  String url,desc,title;

  BlogTile({this.url,this.title,this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),
      child: Column(

        children: <Widget>[
          ClipRRect(

              child: CachedNetworkImage(imageUrl:url,height: 500,width: 500,)),

          Text(
            '$title',style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5,),
          Text(
            '$desc'
          ),SizedBox(height: 15,),
        ],
      ),
    );
  }
}
Toastmaker(String s,BuildContext context){
  Toast.show("$s...",context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
}