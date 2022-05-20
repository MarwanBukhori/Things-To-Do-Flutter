import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/widget/loading-indicator.widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            width: 100,
            height: 100,
            child: Builder(
              builder: (context) {
                if (AppUser().user?.photoURL != null)
                  return Image.network(
                    AppUser().user!.photoURL!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                else
                  return Icon(
                    Icons.person,
                    size: 36,
                  );
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                try {
                  LoadingIndicator.showLoadingDialog(context);
                  final ImagePicker _picker = ImagePicker();
                  final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    FirebaseStorage storage = FirebaseStorage.instance;
                    final ref = storage.ref('images/defaultProfile.png');

                    await ref.putFile(File(image.path));
                    final url = await ref.getDownloadURL();
                    // print(url);
                    await AppUser().user!.updatePhotoURL(url);
                    // print(AppUser().user);
                    setState(() {});
                  }
                  Navigator.pop(context);
                } catch (e) {
                  Navigator.pop(context);
                  print(e);
                }
              },
              child: Text(
                'Change Image',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppUser().user!.displayName!,
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  iconSize: 16,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final nameController = TextEditingController(
                            text: AppUser.instance.user?.displayName!);
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: nameController,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await AppUser().user!.updateDisplayName(
                                          nameController.text);
                                      Navigator.pop(context);
                                      print(AppUser().user);
                                      setState(() {});
                                    },
                                    child: Text('Update'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.edit, color: Colors.blue),
                )
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppUser.instance.user!.email!,
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  iconSize: 16,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final form = FormGroup({
                          'email': FormControl(
                              value: AppUser.instance.user?.email,
                              validators: [Validators.email]),
                        });

                        return AlertDialog(
                          content: ReactiveForm(
                            formGroup: form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ReactiveTextField(
                                  formControlName: 'email',
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ReactiveFormConsumer(
                                      builder: (BuildContext context,
                                          FormGroup form, Widget? child) {
                                        return ElevatedButton(
                                          onPressed: form.valid
                                              ? () async {
                                            try {
                                              LoadingIndicator
                                                  .showLoadingDialog(
                                                  context);
                                              await AppUser()
                                                  .user!
                                                  .updateEmail(form
                                                  .control('email')
                                                  .value);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              print(AppUser().user);
                                              setState(() {});
                                            } catch (e) {
                                              Navigator.pop(context);
                                              print(e);
                                            }
                                          }
                                              : null,
                                          child: Text('Update'),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.edit, color: Colors.blue),
                )
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}