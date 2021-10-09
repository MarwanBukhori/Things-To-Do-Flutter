import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  String ?id ;
  String title;
  String description;
  String author;
  DateTime? createdDate;

  Task({
    required this.title,
    required this.description,
    required this.author,
    required this.createdDate,
    this.id});

  static Task fromMap(Map<String, dynamic> data, {String? id}) {

    try{
      return Task(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        author: data['author'] ?? '',
        id: id,
        createdDate: data['createdDate'] !=null
            ? (data['createdDate'] as Timestamp).toDate()
            : null);

    }catch(e){
      print(e);
      throw(e);
    }

  }

  //to convert object to map string dynamic
  Map<String, Object?> toMap() {
    return {
      'title': title,
      'description': description,
      'author': author,
      'createdDate' : createdDate
    };
  }


}

// List<Task> taskList = [
//   Task(title: 'Task 1', description: 'Task 1 Description'),
//   Task(title: 'Task 2', description: 'Task 2 Description'),
//   Task(title: 'Task 3', description: 'Task 3 Description'),
// ];



