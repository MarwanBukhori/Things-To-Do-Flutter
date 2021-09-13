import 'package:flutter/material.dart';
import 'package:flutter_note/model/task.model.dart';
import 'package:flutter_note/providers/task-list.provider.dart';
import 'package:flutter_note/screen/add-task.screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Consumer<TaskListProvider>(
        builder: (context, taskListProvider, child) {
          final taskList = taskListProvider.taskList;

          return ListView(
            children: List.generate(
              taskList.length,
                  (i) {
                return TaskContainer(
                  task: taskList[i],
                  index: i,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // final taskListProvider =
          //     Provider.of<TaskListProvider>(context, listen: false);
          // final taskList = taskListProvider.taskList;
          // final newTask = Task(
          //     title: 'Task ${taskList.length + 1}',
          //     description: 'Task ${taskList.length + 1} Description');
          // taskListProvider.addTask(newTask);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
} //End of class Home Screen



//TASK CONTAINER SECTION
class TaskContainer extends StatelessWidget {
  final Task task;
  final int index;

  TaskContainer({required this.task, required this.index});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                   task.description,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
             Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.delete),

                onPressed: (){
                  final taskListProvider =
                  Provider.of<TaskListProvider>(context, listen: false);
                  taskListProvider.deleteTask(index);

                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
