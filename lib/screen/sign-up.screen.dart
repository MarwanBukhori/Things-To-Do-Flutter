import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/screen/login.screen.dart';
import 'package:flutter_note/widget/loading-indicator.widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Screen'),
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
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),

          SizedBox(height: 19,),
          ElevatedButton(
            onPressed: () async {
            try{
              //execute(call) custom widget
              LoadingIndicator.showLoadingDialog(context);
              final result = await AppUser.instance.SignUp(
                  email: emailController.text,
                  password: passwordController.text,
                  name: nameController.text
              );

              //tutup model screen utk loading indicator
              Navigator.pop(context);

              //tutup model screen untuk sign up screen
              Navigator.pop(context);

              // showDialog(context: context,
              //   builder: (context){
              //     return AlertDialog(
              //       content: Text('User ${emailController.text} has been registered'),
              //     );
              //   },
              // );

            } catch(e){
              Navigator.pop(context);
              showDialog(context: context,
                builder: (context){
                return AlertDialog(
                  content: Text(e.toString()),
                );
              },
              );
            }
            },
            child: Text('Sign Up'),
          ),
            ElevatedButton(
              onPressed: (){
              Navigator.pop(context);
              },
              child: Text('Already have an account? Sign In'),
            )
          ],
        ),
      )
    );
  }
}