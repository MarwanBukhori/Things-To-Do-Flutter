class Task{
  String title;
  String description;

  Task({required this.title, required this.description});

  static Task fromMap(Map<String, dynamic> data) {
    return Task(
        title: data['title'] as String,
        description: data['description'] as String);
  }

  Map<String, Object> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }


}

// List<Task> taskList = [
//   Task(title: 'Task 1', description: 'Task 1 Description'),
//   Task(title: 'Task 2', description: 'Task 2 Description'),
//   Task(title: 'Task 3', description: 'Task 3 Description'),
// ];



