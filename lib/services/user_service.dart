import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart';

class UserService {
  final supabase = Supabase.instance.client;

  //get details of the user
  Future<User?> getDetailUser(String userId) async {
    try {
      // Query untuk mengambil data user berdasarkan ID
      final response = await supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single(); // Gunakan .single() untuk mendapatkan 1 row saja

      // Konversi dari JSON ke User Object
      return User.fromJson(response);
    } catch (e) {
      print('Error fetching user details: $e');
      return null; // Return null jika terjadi error
    }
  }
}
