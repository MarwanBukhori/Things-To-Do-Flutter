import 'package:dio/dio.dart';

getTodo() async{

  try{
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/todos');
    print(response); // dalam bentuk dynamic? Kena convert kpd object Task
    //return list ; // List <Todo>
  } catch (e) {
    print(e);
  }
}
