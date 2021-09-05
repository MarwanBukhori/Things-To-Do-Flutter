import 'package:flutter/cupertino.dart';
import 'package:flutter_note/model/task.model.dart';

class TaskListProvider extends ChangeNotifier{

  List<Task> taskList = [
    Task(title: 'Task 1', description: 'Task 1 Description'),
    Task(title: 'Task 2', description: 'Task 2 Description'),
    Task(title: 'Task 3', description: 'Task 3 Description'),
  ];

  update(){
    notifyListeners();
  }

  addTask(Task task){
    taskList.add(task);
    notifyListeners();
  }

  deleteTask(index){
    taskList.removeAt(index);
    notifyListeners();
  }
}