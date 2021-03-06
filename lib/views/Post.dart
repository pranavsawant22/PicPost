
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_storage/firebase_storage.dart";
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_app/services/crud.dart';
import 'package:random_string/random_string.dart';
import 'package:toast/toast.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File _image;
  int like = 0;
  String downloadUrl;
  String title,desc,name;
  Crudmethods crudmethods = new Crudmethods();
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;



      _imgFromCamera() async {
        File image = (await ImagePicker.pickImage(
            source: ImageSource.camera, imageQuality: 50
        )) as File;

        setState(() {
          _image = image;
        });
      }

      _imgFromGallery() async {
        File image = (await ImagePicker.pickImage(
            source: ImageSource.gallery, imageQuality: 50
        )) as File;

        setState(() {
          _image = image;
        });
      }
Future uploadBlog() async {

    if (_image != null) {
      // upload the image

      setState(() {
        _isLoading = true;
      });
      StorageReference ref1 = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

       StorageUploadTask task =  ref1.putFile(_image);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();




      Map<String,dynamic> PostMap = {
            "url":url,
            "title":title!=null?title:".",
            "desc":desc!=null?desc:".",
        "name":name,
        "created":FieldValue.serverTimestamp(),
        "likes":like


          };
          await crudmethods.addData(PostMap);
          setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
        }
      }


        void _showPicker(context) {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return SafeArea(
                  child: Container(
                    child: new Wrap(
                      children: <Widget>[
                        new ListTile(
                            leading: new Icon(Icons.photo_library),
                            title: new Text('Photo Library'),
                            onTap: () {
                              _imgFromGallery();
                              Navigator.of(context).pop();
                            }),
                        new ListTile(
                          leading: new Icon(Icons.photo_camera),
                          title: new Text('Camera'),
                          onTap: () {
                            _imgFromCamera();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
          );
        }
        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black54),
              elevation: 0,
              actions: [
                GestureDetector(
                  onTap: () {
                    uploadBlog();
                    Toastmaker("Post Successfully created!!", context);
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.file_upload)),
                )
              ],
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Create", style: TextStyle(
                      color: Colors.black, fontSize: 22
                  )),
                  Text(" Post", style: TextStyle(
                      color: Colors.blue, fontSize: 22
                  ))
                ],
              ),
            ),
            body: _isLoading ? Container(
              child: Center(child: CircularProgressIndicator(),),) : Container(

                padding: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: _formkey,
                  child: ListView(


                      children: <Widget>[

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: _image != null
                                ? Image.file(
                              _image,
                              width: 500,
                              height: 500,
                              fit: BoxFit.contain,
                            )
                                : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              width: 500,
                              height: 500,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          onChanged: (val){
                            if (val!=null)name=val;
                            else name=".";

                          },
                          decoration: InputDecoration(
                            hintText: "Author name",

                          ),
                        ),

                        TextFormField(
                          onChanged: (val){
                            if (val!=null)title=val;
                            else title=".";

                          },
                          decoration: InputDecoration(
                            hintText: "Post Title",

                          ),
                        ),

                        TextFormField(
                          onChanged: (val){
                            if (val!=null)desc=val;
                            else desc=".";
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(

                            hintText: "Post Description",

                          ),
                        ),
                      ],
                    ),
                ),
                )


          );
        }
      }

Toastmaker(String s,BuildContext context){
  Toast.show("$s...",context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
}