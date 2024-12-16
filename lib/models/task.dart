class Task {
  final String id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final DateTime dueDate;
  final String listTaskId;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.dueDate,
    required this.listTaskId,
    required this.createdAt,
  });

  // Convert JSON to Task Object
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      priority: json['priority'],
      dueDate: DateTime.parse(json['due_date']),
      listTaskId: json['list_task_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Convert Task Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'due_date': dueDate.toIso8601String(),
      'list_task_id': listTaskId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
