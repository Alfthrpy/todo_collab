import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/list_task.dart';

class ListTaskService {
  final supabase = Supabase.instance.client;

  // Get All List Tasks by Team ID
  Future<List<ListTask>> getListTasksByTeam(String teamId) async {
    final response =
        await supabase.from('list_tasks').select().eq('team_id', teamId);

    if (response.isNotEmpty) {
      return (response as List).map((data) => ListTask.fromJson(data)).toList();
    }
    return [];
  }

  // Create List Task
  Future<void> createListTask(ListTask listTask) async {
    await supabase.from('list_tasks').insert(listTask.toJson());
  }

  // Delete List Task
  Future<void> deleteListTask(String listTaskId) async {
    await supabase.from('list_tasks').delete().eq('id', listTaskId);
  }
}
