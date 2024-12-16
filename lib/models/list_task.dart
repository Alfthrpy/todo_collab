class ListTask {
  final String id;
  final String name;
  final String teamId;
  final String createdBy;
  final DateTime createdAt;

  ListTask({
    required this.id,
    required this.name,
    required this.teamId,
    required this.createdBy,
    required this.createdAt,
  });

  factory ListTask.fromJson(Map<String, dynamic> json) {
    return ListTask(
      id: json['id'],
      name: json['name'],
      teamId: json['team_id'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'team_id': teamId,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
