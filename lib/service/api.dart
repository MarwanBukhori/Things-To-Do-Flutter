

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_note/model/task.model.dart';

//pakai care future
//data xupdate
Future<List<Task>> getTaskList() async{
  final snapshot = await FirebaseFirestore.instance.collection('tasks').orderBy('title').get();
  return snapshot.docs.map((e) => Task.fromMap(e.data())).toList();
}

//pakai care stream
//data updated everytime new instance passed
Stream<List<Task>> getTaskListStream() {

    final snapshots = FirebaseFirestore.instance.collection('tasks').snapshots();
    return snapshots.map(
            (snapshot) => snapshot.docs.map((e) => Task.fromMap(e.data(), id: e.id)).toList());


}


Future<bool> addTask(Task task) async{
  try {

    //add task ke collection and return doc's id
    final ref = await FirebaseFirestore.instance.collection('tasks').add(
        task.toMap());
    return true;

  } catch(e){
    print(e);
    throw(e);
  }
}


Future<bool> deleteTask(String taskId) async{
  try {

    //add task ke collection and return doc's id
    await FirebaseFirestore.instance.doc('tasks/$taskId').delete();
    return true;

  } catch(e){
    print(e);
    throw(e);
  }
}