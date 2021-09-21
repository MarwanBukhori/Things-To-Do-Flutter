
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier{


  update(){
    notifyListeners();
  }

  AppUser.instance(){
    FirebaseAuth.instance.authStateChanges().listen((user) {
      //sentiasa check bila user berubah
      // if(user != null)
      //   this.user = user;
      // else
      //   this.user = null;
      // print(this.user);
      notifyListeners();
    });

    // final user = FirebaseAuth.instance.currentUser;
    // if(user != null)
    //   this.user = user ;
}

User? get user => FirebaseAuth.instance.currentUser;

factory AppUser() => AppUser.instance();

  signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  signIn(
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
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else
        print(e.toString());
    }
  }


}


// signIn(BuildContext context, {required String email, required String password}) async{
//
//   print(email);
//   print(password);
//
//   final appUser = Provider.of<AppUser>(context, listen: false);
//
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password
//     );
//     print('Sign in Sucessfully');
//     appUser.user = userCredential.user;
//     appUser.update();
//
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       print('No user found for that email.');
//     } else if (e.code == 'wrong-password') {
//       print('Wrong password provided for that user.');
//     } else
//       print(e.toString());
//   }
// }

// signOut(BuildContext context) async{
//   await FirebaseAuth.instance.signOut();
//   final appUser = Provider.of<AppUser>(context, listen:false);
//
//   appUser.user = null;
//   appUser.update();
// }

getUser(){
  final user = FirebaseAuth.instance.currentUser;
  if(user != null)
    print(user);
}