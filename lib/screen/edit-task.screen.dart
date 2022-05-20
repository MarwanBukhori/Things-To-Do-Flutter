import 'package:flutter/material.dart';
import 'package:flutter_note/model/task.model.dart';
import 'package:flutter_note/service/api.dart';
import 'package:flutter_note/widget/loading-indicator.widget.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;

  EditTaskScreen({required this.task});

  final titleTextController = new TextEditingController();
  final descriptionTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleTextController.text = task.title;
    descriptionTextController.text = task.description;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
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
              onPressed: () async {
                try {
                  LoadingIndicator.showLoadingDialog(context);

                  task.title = titleTextController.text;
                  task.description = descriptionTextController.text;

                  final result = await updateTask(task);
                  if (result) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else
                    throw 'Unable to add task';
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
              },
              child: Text('Update Task'),
            )
          ],
        ),
      ),
    );
  }
}