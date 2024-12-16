import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/team.dart';

class TeamService {
  final supabase = Supabase.instance.client;

  // Get All Teams
  Future<List<Team>> getAllTeams() async {
    final response = await supabase.from('teams').select();

    if (response.isNotEmpty) {
      return (response as List).map((data) => Team.fromJson(data)).toList();
    }
    return [];
  }

  // Create Team
  Future<void> createTeam(Team team) async {
    await supabase.from('teams').insert(team.toJson());
  }

  // Update Team
  Future<void> updateTeam(
      String teamId, Map<String, dynamic> updatedData) async {
    await supabase.from('teams').update(updatedData).eq('id', teamId);
  }

  // Delete Team
  Future<void> deleteTeam(String teamId) async {
    await supabase.from('teams').delete().eq('id', teamId);
  }
}
