import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/providers/user.provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
          SizedBox(height: 19,),
          ElevatedButton(
            onPressed: () {
            AppUser().signIn(
                email: emailController.text,
                password: passwordController.text);
            },
            child: Text('Sign In'),
          ),
            ElevatedButton(
              onPressed: (){
                final user = FirebaseAuth.instance.currentUser;
                if(user != null)
                  print(user);
                else
                  print('No firebase user');
              },
              child: Text('Check if logged in'),
            )
          ],
        ),
      )
    );
  }
}