import 'package:flutter/material.dart';
import 'package:flutter_note/model/task.model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//everything dlm ni rebuild disebabkan setState(){}
class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Awesome List App'),
      ),
      body: ListView(
        children: List.generate(
          taskList.length,
              (i) {
            return TaskContainer(
                task: taskList[i],
                index: i,
            );
            },
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print(taskList.length);
          taskList.add(
              Task(title: 'Task ${taskList.length + 1}', description: 'Task ${taskList.length + 1} Description',)
          );
          print(taskList.length);

          //notify suruh build statefull balik
         setState(() {

         });
          },
        child: Icon(Icons.add),
      ),
    );
  }
}


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
                icon: Icon(Icons.edit),
                onPressed: (){

                  /*print(taskList.length);
                  taskList.removeAt(index);
*/

                },
              ),
            ), Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.delete),
                  onPressed: (){
                  task.title = 'New Title';
                  /*print(taskList.length);
                  taskList.removeAt(index);
*/
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
