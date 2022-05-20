import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Task{
  String ?id ;
  String title;
  String description;
  String author;
  DateTime createdDate;
  String authorId;
  bool completed;
  DateTime? dueDate;

  Task({
    required this.title,
    required this.description,
    required this.author,
    required this.createdDate,
    required this.authorId,
    this.completed = false,
    this.dueDate,
    this.id});

  static Task fromMap(Map<String, dynamic> data, {String? id}) {

    try{
      return Task(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        author: data['author'] ?? '',
        id: id,
        createdDate: (data['createdDate'] as Timestamp).toDate(),
          authorId : data['authorId'] ?? '',
        completed: data['completed'] ?? false,
        dueDate: data['dueDate'] != null
            ? (data['dueDate'] as Timestamp).toDate()
            : null,
      );

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
      'createdDate' : createdDate,
      'authorId' : authorId,
      'completed': completed,
      'dueDate': dueDate,
    };
  }

  get createdDateInString {
    return DateFormat('d/M/y').add_jm().format(createdDate);
  }

  get dueDateInString {
    return DateFormat('d/M/y').format(dueDate!);
  }

}




