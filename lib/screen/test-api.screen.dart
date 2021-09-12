import 'package:flutter/material.dart';
import 'package:flutter_note/model/todo.model.dart';
import 'package:flutter_note/service/api.dart';

class TestApiScreen extends StatelessWidget {
  const TestApiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen to test API') ,
      ),
      body: FutureBuilder<List<Todo>>(
        future: getTodo(),
        builder: (context, snapshot){

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), //loading icon while waiting
            );
          } else {
            List<Todo> todoList = snapshot.data!;

            return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final Todo todo = todoList[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Flexible( //nk bagi fit to screen
                          fit: FlexFit.loose,
                          child: Text('${todo.id}. ${todo.title}')),
                      todo.completed  //if completed akan pakai icon ini
                          ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                          : Icon(   //else pakai icon ini
                        Icons.close,
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              },
            );
          }



          }),
    );
  }
}
