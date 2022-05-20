import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_note/model/task.model.dart';
import 'package:flutter_note/providers/user.provider.dart';

Future<List<Task>> getTaskList() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('tasks')
      .where('authorId', isEqualTo: AppUser().user!.uid)
      .get();
  return snapshot.docs.map((e) => Task.fromMap(e.data())).toList();
}

Stream<List<Task>> getTaskListStream() {
  final snapshots = FirebaseFirestore.instance
      .collection('tasks')
      .where('authorId', isEqualTo: AppUser().user!.uid)
      .orderBy('createdDate', descending: true)
      .snapshots();
  return snapshots.map((snapshot) => snapshot.docs
      .map(
        (e) => Task.fromMap(e.data(), id: e.id),
  )
      .toList());
}

Future<bool> addTask(Task task) async {
  try {
    await FirebaseFirestore.instance.collection('tasks').add(task.toMap());
    return true;
  } catch (e) {
    print(e);
    throw (e);
  }
}

Future<bool> updateTask(Task task) async {
  try {
    await FirebaseFirestore.instance
        .doc('tasks/${task.id}')
        .update(task.toMap());
    return true;
  } catch (e) {
    print(e);
    throw (e);
  }
}

Future<bool> deleteTask(String taskId) async {
  try {
    await FirebaseFirestore.instance.doc('tasks/$taskId').delete();
    return true;
  } catch (e) {
    print(e);
    throw (e);
  }
}

Future<bool> bulkDeleteTask() async {
  try {
    final batch = FirebaseFirestore.instance.batch();

    final snapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('authorId', isEqualTo: AppUser().user!.uid)
        .get();
    snapshot.docs.forEach((doc) {
      batch.delete(doc.reference);
    });

    await batch.commit();
    return true;
  } catch (e) {
    print(e);
    throw (e);
  }
}