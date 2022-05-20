import 'package:flutter/material.dart';
import 'package:flutter_note/model/task.model.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/screen/camera.screen.dart';
import 'package:flutter_note/service/api.dart';
import 'package:flutter_note/widget/loading-indicator.widget.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleTextController = new TextEditingController();

  final descriptionTextController = new TextEditingController();

  final dueDateTextController = new TextEditingController();

  DateTime? dueDate;

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
            TextField(
              readOnly: true,
              controller: dueDateTextController,
              decoration: InputDecoration(
                labelText: 'Due Date',
                suffixIcon: IconButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        Duration(days: 365),
                      ),
                    );
                    if (date != null) {
                      dueDate = date;
                      dueDateTextController.text =
                          DateFormat('d/M/y').format(date);
                    }
                  },
                  icon: Icon(Icons.event),
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CameraScreen()));
              },
              child: Text('Add Picture'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  LoadingIndicator.showLoadingDialog(context);

                  final task = Task(
                      description: descriptionTextController.text,
                      title: titleTextController.text,
                      author: AppUser().user!.displayName ?? '',
                      createdDate: DateTime.now(),
                      authorId: AppUser().user!.uid,
                      dueDate: dueDate);
                  // Provider.of<TaskListProvider>(context, listen: false)
                  //     .addTask(task);
                  final result = await addTask(task);
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
              child: Text('Add Task'),
            )
          ],
        ),
      ),
    );
  }
}