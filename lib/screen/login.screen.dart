import 'package:flutter/material.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/screen/sign-up.screen.dart';
import 'package:flutter_note/widget/loading-indicator.widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final form = FormGroup(
    {
      'email': FormControl<String>(
          validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(
          validators: [Validators.required, Validators.minLength(1)]),
    },
  );

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
              SizedBox(height: 10),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  print(form.value);
                  return ElevatedButton(
                    onPressed: form.valid
                        ? () async {
                      try {
                        LoadingIndicator.showLoadingDialog(context);
                        await AppUser.instance.signIn(
                            email: form.control('email').value,
                            password: form.control('password').value);
                        Navigator.pop(context);
                      } catch (e) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(e.toString()),
                            );
                          },
                        );
                      }
                    }
                        : null,
                    child: Text('Sign In '),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text("Don't an account? Sign Up "),
              )
            ],
          ),
        ),
      ),
    );
  }
}