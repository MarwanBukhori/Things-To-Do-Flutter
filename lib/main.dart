import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/providers/task-list.provider.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/screen/landing-page.screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'model/task.model.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
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
    final appUser = AppUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskListProvider>.value(value: taskListProvider),
        ChangeNotifierProvider<AppUser>.value(value: appUser)
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LandingPage(),
          );
        },
      ),
    );
  }
}