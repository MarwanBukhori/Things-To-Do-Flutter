import 'package:flutter/material.dart';
import 'package:flutter_note/screen/task-list.screen.dart';
import 'package:flutter_note/screen/login.screen.dart';
import 'package:flutter_note/screen/test-api.screen.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskListScreen(),
                ),
              );
            },
            child: Text('Task List'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TestApiScreen(),
                ),
              );
            },
            child: Text('Test API'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            child: Text('Login Screen'),
          )
        ],
      ),
    );
  }
}