import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/models/user.dart';

class AuthService{
FirebaseAuth _auth = FirebaseAuth.instance;
User1 _userfromfirebase (FirebaseUser user){
  return user !=null? User1(UserId: user.uid):null;
}
Future signinwithemailandpassword(String email,String password) async {
  try{
    AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser firebaseUser = authResult.user;
    return _userfromfirebase(firebaseUser);
  }
  catch(e){print("Sign-In error : " + e.toString());}
}
Future signupwithemailandpassword(String email,String password,String name) async{
try{
  AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  FirebaseUser firebaseUser = authResult.user;
  return _userfromfirebase(firebaseUser);
  }
  catch(e){print("Sign-Up error : " + e.toString());}
}
Future Signout() async{
  try{
return await _auth.signOut();  }
  catch(e){
    print("Sign-Out error : " + e.toString());
    return null;
  }
}
}