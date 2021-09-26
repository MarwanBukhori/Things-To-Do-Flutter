
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier{


  update(){
    notifyListeners();
  }

  AppUser._(){
    FirebaseAuth.instance.authStateChanges().listen((user) {

      notifyListeners();
    });


}

User? get user => FirebaseAuth.instance.currentUser;

factory AppUser() => AppUser._();

static AppUser get instance => AppUser();

  signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  Future<void>signIn(
      { required String email,
        required String password}) async{

    print('Email: $email');
    print('Password: $password');

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password
      );
      print('Sign in Sucessfully');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw('Wrong password provided for that user.');
      } else
        throw(e.toString());
    }
  }


Future<bool>SignUp({
  required String email,
  required String password,
  required String name }) async{
    try{
      final credential = await FirebaseAuth.
      instance.createUserWithEmailAndPassword(email: email, password: password);

      //edit nama utk new-created user
      user!.updateDisplayName(name);

      return true;

    }catch(e){
      throw(e);
    }
}

}

getUser(){
  final user = FirebaseAuth.instance.currentUser;
  if(user != null)
    print(user);
}