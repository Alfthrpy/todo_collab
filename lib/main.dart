import 'package:flutter/material.dart';
import 'package:todo_team/app.dart';
import 'package:todo_team/config/supabase_config.dart'; // Import file app.dart

void main() {
  SupabaseConfig.init();
  runApp(const App()); // Jalankan aplikasi dengan widget App
}
