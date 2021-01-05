
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/services/crud.dart';
import 'package:quiz_app/views/Post.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:readmore/readmore.dart';
import 'package:toast/toast.dart';
class Home extends StatefulWidget {
  String name;
  Home({this.name});

  @override
  _HomeState createState() => _HomeState(name);
}


class _HomeState extends State<Home> {
  String name,name1;
  int like=0;

  bool hi = false;
  _increment(int a,bool b){
    a =a+1;
    b = !b;
  }
  Crudmethods crudmethods = new Crudmethods();
  Stream poststream ;
Widget PostList(){
  return poststream!= null ? Container(
    padding: EdgeInsets.only(top: 0,bottom: 30),
    child:StreamBuilder(

      stream: poststream,
      builder: (context,snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(

              itemCount: snapshot.data.documents.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print("object");
                print(index);
                return BlogTile(
                  desc: snapshot.data.documents[index].data["desc"],
                  name: snapshot.data.documents[index].data["name"],
                  title: snapshot.data.documents[index].data["title"],
                  url: snapshot.data.documents[index].data["url"],
                  like: snapshot.data.documents[index].data["likes"],

                );
              }
          );
        }
        else{
return Container(
  child: Center(
    child: CircularProgressIndicator(),
  ),
);
        }
      }

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
          Toastmaker("Post Successfully created!!", context);
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

class BlogTile extends StatefulWidget {
  String url,desc,title,name;
  int like=0;

  bool hi = false;
  _increment(int a,bool b){
    a =a+1;
    b = !b;
  }
  BlogTile({this.url,this.title,this.desc,this.name,this.like});

  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
padding: EdgeInsets.only(bottom:20),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(35),
          border: Border.all(color: Colors.black12)
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(

          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  '\n    ${widget.name}',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),

                textAlign: TextAlign.start,
              ),
            ),
            ClipRRect(

                child: CachedNetworkImage(imageUrl:widget.url,height: 350,width: 350,),
            borderRadius:BorderRadius.circular(20),),

            Text(
              '${widget.title}',style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5,),
            ReadMoreText('${widget.desc}',
              trimLines: 3,
              colorClickableText: Colors.blueAccent,

              trimCollapsedText: '...Expand',
              trimExpandedText: ' Collapse ',
            ),SizedBox(height: 10,),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[

                  Align(alignment: Alignment.center,
                   child: GestureDetector(

                         onTap: (){
           },

                       child: Icon(Icons.whatshot,size: 35,color: true?Colors.red:Colors.black54)),
                 ),

Text('${0}'),
             ],
           )

          ],
        ),
      ),
    );
  }
}
Toastmaker(String s,BuildContext context){
  Toast.show("$s...",context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
}
