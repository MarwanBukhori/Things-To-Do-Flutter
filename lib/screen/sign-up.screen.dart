import 'package:flutter/material.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/widget/loading-indicator.widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final form = FormGroup(
    {
      'email': FormControl<String>(
          validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(
          validators: [Validators.required, Validators.minLength(6)]),
      'name': FormControl<String>(
          validators: [Validators.required, Validators.minLength(1)]),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Screen'),
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
                  suffixIcon: Icon(Icons.email),
                ),
                validationMessages: (control) {
                  return {
                    ValidationMessage.required: 'This field is required',
                    ValidationMessage.email: 'Email is invalid'
                  };
                },
                keyboardType: TextInputType.emailAddress,
              ),
              ReactiveTextField(
                formControlName: 'password',
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password', suffixIcon: Icon(Icons.lock)),
                validationMessages: (control) {
                  return {
                    ValidationMessage.minLength: 'Min password length is 6',
                  };
                },
              ),
              ReactiveTextField(
                formControlName: 'name',
                decoration: InputDecoration(
                    labelText: 'Name', suffixIcon: Icon(Icons.person)),
                validationMessages: (control) {
                  return {
                    ValidationMessage.required: 'This field is required '
                  };
                },
              ),
              SizedBox(height: 10),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    onPressed: form.valid
                        ? () async {
                      try {
                        LoadingIndicator.showLoadingDialog(context);
                        await AppUser.instance.signUp(
                          email: form.control('email').value,
                          password: form.control('password').value,
                          name: form.control('name').value,
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // showDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return AlertDialog(
                        //       content: Text(
                        //           'User ${emailController.text} has been registered'),
                        //     );
                        //   },
                        // );
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
                    child: Text('Sign Up '),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Already have an account? Sign In '),
              )
            ],
          ),
        ),
      ),
    );
  }
}