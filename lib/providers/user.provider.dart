
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppUser extends ChangeNotifier{

  bool loggedIn = false;

  update(){
    notifyListeners();
  }

  AppUser.instance(){
    final user = FirebaseAuth.instance.currentUser;
    if(user != null)
      loggedIn = true ;
}

  factory AppUser() => AppUser.instance();
}


signIn(BuildContext context, {required String email, required String password}) async{

  print(email);
  print(password);

  final appUser = Provider.of<AppUser>(context, listen: false);

  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    print('Sign in Sucessfully');
    appUser.loggedIn = true;
    appUser.update();

  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else
      print(e.toString());
  }
}

signOut(BuildContext context) async{
  await FirebaseAuth.instance.signOut();
  final appUser = Provider.of<AppUser>(context, listen:false);

  appUser.loggedIn = false;
  appUser.update();

}