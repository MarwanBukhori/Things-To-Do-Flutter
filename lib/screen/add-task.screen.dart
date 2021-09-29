import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/model/task.model.dart';
import 'package:flutter_note/providers/task-list.provider.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/service/api.dart';
import 'package:flutter_note/widget/loading-indicator.widget.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  final titleTextController = new TextEditingController();
  final descriptionTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: titleTextController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: descriptionTextController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async{
                try{
                  LoadingIndicator.showLoadingDialog(context);
                  final task = Task(
                      description: descriptionTextController.text,
                      title: titleTextController.text,
                      author: AppUser().user!.displayName ?? '');
                  // Provider.of<TaskListProvider>(context, listen: false)
                  //     .addTask(task);
                  final result = await addTask(task);

                  // if berjaya
                  if(result) {
                    // satu utk skill screen loading indicator
                    Navigator.pop(context);
                    // satu utk kill skill screen add task
                    Navigator.pop(context);
                  }else
                    throw 'Unable to add task';

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
              child: Text('Add Task'),
            )
          ],
        ),
      ),
    );
  }
}