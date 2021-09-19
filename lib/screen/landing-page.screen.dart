import 'package:flutter/material.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/screen/home.screen.dart';
import 'package:flutter_note/screen/login.screen.dart';
import 'package:provider/provider.dart';



class LandingPage extends StatelessWidget {

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);

    if(appUser.loggedIn) {
      print('Logged in');
      return HomeScreen();

    } else {
      print('Not logged in');
      return LoginScreen();
    }
  }

  //condition for login / xlogin

}
