import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import '../widgets/custom_snackbar.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TaskService _taskService = TaskService();
  final String userId;

  AddTaskScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text;
                String description = descriptionController.text;

                if (title.isNotEmpty) {
                  Task newTask = Task(id: '', title: title, description: description, isCompleted: false);
                  await _taskService.addTask(userId, newTask);
                  Navigator.pop(context);

                } else {
                  CustomSnackBar.showSnackBar(context, 'Title cannot be empty.');
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
 }
