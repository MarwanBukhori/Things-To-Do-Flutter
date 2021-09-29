class Task{
  String ?id ;
  String title;
  String description;
  String author;

  Task({required this.title, required this.description, required this.author, this.id});
  static Task fromMap(Map<String, dynamic> data, {String? id}) {
    return Task(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        author: data['author'] ?? '',
        id: id,
      );
  }

  //to convert object to map string dynamic
  Map<String, Object> toMap() {
    return {
      'title': title,
      'description': description,
      'author': author,
    };
  }


}

// List<Task> taskList = [
//   Task(title: 'Task 1', description: 'Task 1 Description'),
//   Task(title: 'Task 2', description: 'Task 2 Description'),
//   Task(title: 'Task 3', description: 'Task 3 Description'),
// ];



