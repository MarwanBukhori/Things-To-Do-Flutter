import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/model/task.model.dart';
import 'package:flutter_note/providers/task-list.provider.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/screen/add-task.screen.dart';
import 'package:flutter_note/service/api.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final taskList = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [

          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () async{

              await AppUser.instance.signOut();
              // AppUser().signOut();
              // FirebaseAuth.instance.signOut();
              // boleh juga pakai
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Task>>(
        stream: getTaskListStream(),
        builder: (context, snapshot) {

          if(snapshot.hasData){
            List<Task> taskList = snapshot.data!;
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
          } else return Container();

        }
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

                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    task.author,
                    style: TextStyle(fontSize: 20),
                  ),

                  task.createdDate != null ?
                  Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        task.createdDate.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ) : Container (),
                ],
              ),
            ),
             Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.delete),

                onPressed: () async{
                  print(task.id);
                  if(task.id != null) await deleteTask(task.id!);
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
