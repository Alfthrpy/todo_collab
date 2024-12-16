import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task_assignment.dart';

class TaskAssignmentService {
  final supabase = Supabase.instance.client;

  // Get Task Assignments by Task ID
  Future<List<TaskAssignment>> getAssignmentsByTask(String taskId) async {
    final response =
        await supabase.from('task_assignments').select().eq('task_id', taskId);

    if (response.isNotEmpty) {
      return (response as List)
          .map((data) => TaskAssignment.fromJson(data))
          .toList();
    }
    return [];
  }

  // Assign Task to User
  Future<void> assignTask(TaskAssignment taskAssignment) async {
    await supabase.from('task_assignments').insert(taskAssignment.toJson());
  }

  // Remove Task Assignment
  Future<void> deleteAssignment(int assignmentId) async {
    await supabase.from('task_assignments').delete().eq('id', assignmentId);
  }
}
