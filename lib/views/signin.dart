import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/helper/help.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signup.dart';
import 'package:toast/toast.dart';
class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formkey = GlobalKey<FormState>();
  String email,pass,name;
  bool isLoading=false,_passwordVisible = false;
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  AuthService authService = new AuthService();
  signIn() async{
    if (_formkey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      await authService.signinwithemailandpassword(email, pass).then((value){
        if(value!=null){
          setState(() {
            isLoading = false;
          });
Helperfunction.saveUserLogIn(isLoggedIn: true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=>Home(name:name)

          ));
        }
        else{

           Toast.show("Password Incorrect...", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
           setState(() {
             isLoading = false;
           });
        }
      });

    }

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Container(

        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/bulb2.jpg"),
    fit: BoxFit.cover,
    ),
    ),
child: isLoading?Container(
  child: Center(
    child: CircularProgressIndicator(),
  ),
):
Form(
  key: _formkey,
  child:   Container(
    margin: EdgeInsets.only(left:15,right:15),
    child: ListView(
      children: <Widget>[
        Text('\nHello \nSign in!',
        style:TextStyle(
          color:Colors.white,
          fontSize: 55

        )
        ),
SizedBox(height: 300),
        TextFormField(
          validator: (val){return val.isEmpty?"Enter correct username":null;},
          decoration: InputDecoration(

              hintText: "Username"
          ),
          onChanged: (val)=>name=val,
        ),
        SizedBox(height: 20,),
        TextFormField(
          validator: (val){return val.isEmpty ? "Enter correct email":null;},
          decoration: InputDecoration(
            hintText: "Email address",
          ),
          onChanged: (val)=>{
            email = val
          },
        ),
        SizedBox(height: 18),
        TextFormField(
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            hasFloatingPlaceholder: true,
            fillColor: Colors.transparent,
            labelText: "Password",
            suffixIcon: GestureDetector(
              onLongPress: () {
                setState(() {
                  _passwordVisible = true;
                });
              },
              onLongPressUp: () {
                setState(() {
                  _passwordVisible = false;
                });
              },
              child: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "*Password needed";
            }
            else return null;
          },
          onChanged: (val)=>{
            pass = val
          },
        ),
        SizedBox(height: 18,),

        GestureDetector(
          onTap: (){
            signIn();
          },
          child: Container(
            child: Text('Sign in',style: TextStyle(color: Colors.white,fontSize: 20),),
            alignment: Alignment.center,
            width: 2,

            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              color: Colors.lightBlue,
            ),

          ),
        ),
        SizedBox(height:20),


        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Don't have an account? ",style: TextStyle(fontSize: 18),textAlign: TextAlign.start,),
            GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=>SignUp()));
                  },
                child: Text("Sign Up",style:TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blue[900])))
          ],
        )
        

      ],
    )
  ),
),

        ),
    );
  }
}

