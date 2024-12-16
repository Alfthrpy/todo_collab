import 'package:flutter/material.dart';
import 'package:todo_team/models/list_task.dart';
import 'package:todo_team/models/task.dart';
import 'package:todo_team/services/list_task_service.dart';
import 'package:todo_team/services/task_service.dart';
import 'package:uuid/uuid.dart';

class TaskCrudScreen extends StatefulWidget {
  const TaskCrudScreen({super.key});

  @override
  _TaskCrudScreenState createState() => _TaskCrudScreenState();
}

class _TaskCrudScreenState extends State<TaskCrudScreen> {
  final TaskService taskService = TaskService();
  final ListTaskService listTaskService = ListTaskService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  late final String exampleLisTaskId;

  // Untuk dropdown priority
  String selectedPriority = 'Medium';

  List<Task> tasks = [];
  late ListTask listTask;

  // Untuk menyimpan task yang sedang diedit
  Task? taskToEdit;

  @override
  void initState() {
    super.initState();

    // Inisialisasi UUID sekali saja
    exampleLisTaskId = "30000000-0000-0000-0000-000000000001";

    // Ambil data task saat pertama kali dijalankan
    fetchListTasks();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final fetchedTasks = await taskService.getAllTasks(exampleLisTaskId);
    setState(() {
      tasks = fetchedTasks;
    });
  }

  Future<void> fetchListTasks() async {
    final fetchedListTasks = await listTaskService
        .getListTasksByTeam("10000000-0000-0000-0000-000000000001");
    setState(() {
      listTask = fetchedListTasks[0];
    });
  }

  Future<void> addTask() async {
    // Buat task baru dengan UUID baru
    Task newTask = Task(
      id: const Uuid().v4(),
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      status: 'Pending',
      priority: selectedPriority,
      dueDate: DateTime.parse(dueDateController.text.trim()),
      listTaskId: exampleLisTaskId,
      createdAt: DateTime.now(),
    );

    // Simpan task baru ke database melalui service
    await taskService.createTask(newTask);

    // Bersihkan input controller dan refresh tampilan task
    titleController.clear();
    descriptionController.clear();
    dueDateController.clear();
    fetchTasks();
  }

  Future<void> updateTask() async {
    if (taskToEdit == null) return;

    // Membuat data pembaruan dalam bentuk Map<String, dynamic>
    Map<String, dynamic> updatedData = {
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'priority': selectedPriority,
      'dueDate': DateTime.parse(dueDateController.text.trim()),
    };

    // Panggil method updateTask dengan taskId dan data yang diperbarui
    await taskService.updateTask(taskToEdit!.id, updatedData);

    // Bersihkan input controller dan refresh tampilan task
    titleController.clear();
    descriptionController.clear();
    dueDateController.clear();
    setState(() {
      taskToEdit = null;
    });
    fetchTasks();
  }

  Future<void> deleteTask(String taskId) async {
    await taskService.deleteTask(taskId);
    fetchTasks();
  }

  // Menampilkan form edit jika task dipilih
  void editTask(Task task) {
    setState(() {
      taskToEdit = task;
      titleController.text = task.title;
      descriptionController.text = task.description;
      selectedPriority = task.priority;
      dueDateController.text =
          task.dueDate.toString().split(' ')[0]; // Ambil tanggal saja
    });
  }

  // Menampilkan date picker untuk memilih tanggal
  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: taskToEdit == null ? DateTime.now() : taskToEdit!.dueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dueDateController.text =
            picked.toString().split(' ')[0]; // Ambil tanggal saja
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task CRUD'),
      ),
      body: Column(
        children: [
          Text(listTask.name),
          // Form Input untuk add atau edit
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                // Dropdown untuk priority
                DropdownButton<String>(
                  value: selectedPriority,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPriority = newValue!;
                    });
                  },
                  items: <String>['Low', 'Medium', 'High']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // Field untuk due date, menggunakan TextField dengan date picker
                TextField(
                  controller: dueDateController,
                  decoration: const InputDecoration(labelText: 'Due Date'),
                  readOnly: true,
                  onTap: () => _selectDueDate(context),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: taskToEdit == null ? addTask : updateTask,
                  child: Text(taskToEdit == null ? 'Add Task' : 'Update Task'),
                ),
              ],
            ),
          ),
          // List of Tasks
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Row(
                      children: [
                        // Due Date
                        Chip(
                          label: Text(
                            'Due: ${task.dueDate.toString().split(' ')[0]}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        // Priority
                        Chip(
                          label: Text(
                            'Priority: ${task.priority}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: task.priority == 'High'
                              ? Colors.red
                              : task.priority == 'Medium'
                                  ? Colors.orange
                                  : Colors.green,
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => editTask(task),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteTask(task.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
