import 'package:flutter/material.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signin.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
@override

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  String email,pass,conf_pass,name;
  bool isLoading=false,_passwordVisible = false;
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  AuthService authService = new AuthService();

  signUp() async{
    if (_formkey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
await authService.signupwithemailandpassword(email, pass, name).then((value){
  if (value!=null){
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>Home(name:name)

    ));
  }
  else{
    Navigator.pop(context);
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
            image: AssetImage("assets/images/signup-page.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: isLoading?Container(
          child:Center(
            child: CircularProgressIndicator(),
          )
        ):Form(
          key: _formkey,
          child:   Container(
              margin: EdgeInsets.only(left:15,right:15),
              child: ListView(
                children: <Widget>[
                  Text('\nCreate Your Account!',
                      style:TextStyle(
                          color:Colors.white,
                          fontSize: 55

                      )
                  ),
                  SizedBox(height: 300),
                  TextFormField(
                    validator: (val){return val.isEmpty?"Enter correct username":null;},
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                      hintText: "Username"
                    ),
                    onChanged: (val)=>name=val,
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    validator: (val){return val.isEmpty ? "Enter correct email":null;},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                      hintText: "Email address",
                    ),
                    onChanged: (val)=>{
                      email = val
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
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
                  SizedBox(height: 20,),


                  GestureDetector(
                    onTap: (){signUp();
                    },
                    child: Container(
                      child: Text('Sign up',style: TextStyle(color: Colors.white,fontSize: 20),),
                      alignment: Alignment.center,
                      width: 2,

                      height: 39,
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
                      Text("Already have an account? ",style: TextStyle(fontSize: 18),textAlign: TextAlign.start,),
                      GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context)=>Signin()));
                          },
                          child: Text("Sign In",style:TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blue[900])))
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
