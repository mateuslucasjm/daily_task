class Task {
  String? id;
  String title;
  bool completed;

  Task({
    this.id,
    required this.title,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'completed': completed,
    };
  }

  factory Task.fromMap(Map<String, dynamic> data, [String? id]) {
    return Task(
      id: id,
      title: data['title'],
      completed: data['completed'] ?? false,
    );
  }
}