import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/authentication_service.dart';
import '../services/task_service.dart';
import '../widgets/task_item.dart';
import 'add_task_screen.dart';
import 'login_screen.dart';

class TaskListScreen extends StatefulWidget {
  final String userId;
  const TaskListScreen({super.key, required this.userId});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskService _taskService = TaskService();
  final AuthenticationService _authService = AuthenticationService();
  late List<Task> tasks;
  late String userId;
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    _loadTasks();
  }

  void _loadTasks() async {
    tasks = await _taskService.getTasks(userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskItem(task: tasks[index], userId: userId);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen(userId: userId)),
          );
          _loadTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

