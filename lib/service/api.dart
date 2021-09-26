

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_note/model/task.model.dart';

Future<List<Task>>getTaskList() async{
  final snapshot = await FirebaseFirestore.instance.collection('tasks').get();

  return snapshot.docs.map((e) => Task.fromMap(e.data())).toList();


}