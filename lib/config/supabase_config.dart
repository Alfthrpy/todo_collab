import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static final client = Supabase.instance.client;

  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://cnwfmmxuqrleotacsdci.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNud2ZtbXh1cXJsZW90YWNzZGNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4MTI1NTEsImV4cCI6MjA0OTM4ODU1MX0.RUPHXfZF5FxXAogzj3aF_ZBdTqilqw9GT-9YWJ4_ar4',
    );
  }
}
