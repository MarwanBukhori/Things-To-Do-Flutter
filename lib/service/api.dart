import 'package:dio/dio.dart';
import 'package:flutter_note/model/todo.model.dart';

//kena wrap dgn future bcoz kita main dgn http, get ...
Future<List<Todo>> getTodo() async{

//Future<List<Todo>?> getTodo() async{
//future of null or todo, return either one is ok to highlight the use of '?'
  try{
    Response response =
        await Dio().get('https://jsonplaceholder.typicode.com/todos');

    //convert data api kpd type list
    List<dynamic> data = response.data;

    //convert List<dynamic> kpd List<Todo> pakai .map, for every item to will iterate kepada List
    List<Todo> todoList = data.map((e) => Todo.fromMap(e)).toList();

   //result of this function list <todo>
    return todoList;

  } catch (e) {

    print(e);
    return [];

  }
}
