import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/screen/sign-up.screen.dart';
import 'package:flutter_note/widget/loading-indicator.widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final form = FormGroup({
    'email' : FormControl<String>(validators: [Validators.required, Validators.email]),
    'password' : FormControl<String>(validators: [Validators.required, Validators.minLength(1)]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ReactiveTextField(
                formControlName: 'email',
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),

              ReactiveTextField(
                formControlName: 'password',
                decoration: InputDecoration(
                  labelText: 'Password',
                ),

              ),
            SizedBox(height: 19,),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                print(form.value);
              return ElevatedButton(
                onPressed: form.valid
                    ? () async {
                  try{
                    //execute(call) custom widget
                    LoadingIndicator.showLoadingDialog(context);
                    await AppUser.instance.signIn(
                        email: form.control('email').value,
                        password: form.control('password').value);

                    //tutup model screen utk loading indicator
                    Navigator.pop(context);
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
                } : null,
                child: Text('Sign In'),
              );
            },),


              ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>SignUpScreen()));
                },
                child: Text('Dont have an account? Sign Up'),
              )
            ],
          ),
        ),
      )
    );
  }
}