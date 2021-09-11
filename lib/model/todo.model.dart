class Todo{  // a class

  // attributes variables
  int userId;
  int id;
  String title;
  bool completed;

  //constructor
  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed
  });

  // a class method
  // return type Todo
  static Todo fromMap(Map<String, dynamic> data) {
    return Todo(
      userId: data['userId'],
      id: data['id'],
      title: data['title'],
      completed: data['completed']);
  }
}