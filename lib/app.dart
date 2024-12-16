import 'package:flutter/material.dart';
import 'package:todo_team/screens/debugging_data/task_crud_screen.dart'; // Sesuaikan path dengan struktur folder kamu

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo Team App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Kamu bisa ganti warna tema utama di sini
      ),
      home: const TaskCrudScreen(), // TaskCrudScreen sebagai halaman utama
    );
  }
}
