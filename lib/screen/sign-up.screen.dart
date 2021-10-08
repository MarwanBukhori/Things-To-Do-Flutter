import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/screen/login.screen.dart';
import 'package:flutter_note/widget/loading-indicator.widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final form = FormGroup({
    'email' : FormControl<String>(validators: [Validators.required, Validators.email]),
    'password' : FormControl<String>(validators: [Validators.required, Validators.minLength(6)]),
    'name' : FormControl<String>(validators: [Validators.required, Validators.minLength(1)]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Screen'),
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
                validationMessages: (control){
                  return {
                    ValidationMessage.required : 'This field is required',
                    ValidationMessage.email : 'Email is not valid'
                  };
                },
              ),
              ReactiveTextField(
                formControlName: 'password',
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validationMessages: (control){
                  return {
                    ValidationMessage.minLength : 'Min password length is 6'
                  };
                },
              ),
              ReactiveTextField(
                formControlName: 'name',
                decoration: InputDecoration(
                  labelText: 'Name',
                ),

                validationMessages: (control){
                  return {
                    ValidationMessage.required : 'This field is required'
                  };
                },
              ),

            SizedBox(height: 19,),
            ReactiveFormConsumer(
              builder: (context, form, child){
                return ElevatedButton(
                  onPressed: form.valid ?() async {
                    try{
                      //execute(call) custom widget
                      LoadingIndicator.showLoadingDialog(context);
                      final result = await AppUser.instance.SignUp(
                          email: form.control('email').value,
                          password: form.control('password').value,
                          name: form.control('name').value
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
                  } : null,
                  child: Text('Sign Up'),
                );
              },
            ),


              ElevatedButton(
                onPressed: () {
                Navigator.pop(context);
                },
                child: Text('Already have an account? Sign In'),
              )
            ],
          ),
        ),
      )
    );
  }
}