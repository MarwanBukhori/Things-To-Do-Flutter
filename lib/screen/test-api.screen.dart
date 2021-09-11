import 'package:flutter/material.dart';
import 'package:flutter_note/service/api.dart';

class TestApiScreen extends StatelessWidget {
  const TestApiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen to test API') ,
      ),
      body: FutureBuilder<dynamic>(
        future: getTodo(),
        builder: (context, snapshot){
      return Container();
          }),
    );
  }
}
