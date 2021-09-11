import 'package:flutter/material.dart';
import 'package:flutter_note/providers/task-list.provider.dart';
import 'package:flutter_note/screen/test.screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'model/task.model.dart';

void main() async{
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final taskList = box.read('taskList');
    final List<Task> list = taskList != null
        ? List.from((taskList as List<dynamic>).map((e) => Task.fromMap(e)))
        : [];

    final taskListProvider = TaskListProvider(taskList: list);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TaskListProvider>.value(value: taskListProvider)
        ],
        child: Builder(
        builder: (context) {
          return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
          primarySwatch: Colors.blue,
          ),
          home: TestScreen(),
          );
          },
           ),
            );
  }
}