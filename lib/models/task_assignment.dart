class TaskAssignment {
  final int id;
  final String taskId;
  final String userId;
  final DateTime assignedAt;
  final DateTime createdAt;

  TaskAssignment({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.assignedAt,
    required this.createdAt,
  });

  factory TaskAssignment.fromJson(Map<String, dynamic> json) {
    return TaskAssignment(
      id: json['id'],
      taskId: json['task_id'],
      userId: json['user_id'],
      assignedAt: DateTime.parse(json['assigned_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'user_id': userId,
      'assigned_at': assignedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
