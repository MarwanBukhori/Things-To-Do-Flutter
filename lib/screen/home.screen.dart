

import 'package:flutter/material.dart';
import 'package:flutter_note/model/task.model.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Awesome List App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:
          List.generate(
              taskList.length,
                  (index) {
          return TaskContainer(task: taskList[index]);
      }),
      ),
      );

  }
}

class TaskContainer extends StatelessWidget {
 final Task task;

 TaskContainer({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(
            color: Colors.grey.shade200
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                task.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 5
            ),
            Text(
              task.description,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

