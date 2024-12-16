import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task.dart';

class TaskService {
  final supabase = Supabase.instance.client;

  // Get All Tasks
  Future<List<Task>> getAllTasks(String listTaskId) async {
    final response =
        await supabase.from('tasks').select().eq('list_task_id', listTaskId);

    if (response.isNotEmpty) {
      return (response as List).map((data) => Task.fromJson(data)).toList();
    }
    return [];
  }

  // Create Task
  Future<void> createTask(Task task) async {
    await supabase.from('tasks').insert(task.toJson());
  }

  // Update Task
  Future<void> updateTask(
      String taskId, Map<String, dynamic> updatedData) async {
    await supabase.from('tasks').update(updatedData).eq('id', taskId);
  }

  // Delete Task
  Future<void> deleteTask(String taskId) async {
    await supabase.from('tasks').delete().eq('id', taskId);
  }
}
