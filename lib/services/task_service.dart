import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Task>> getTasks(String userId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(Constants.usersCollection)
        .doc(userId)
        .collection(Constants.tasksCollection)
        .get();

    return querySnapshot.docs.map((doc) {
      return Task(
        id: doc.id,
        title: doc['title'],
        description: doc['description'],
        isCompleted: doc['isCompleted'],
      );
    }).toList();
  }

  Future<void> addTask(String userId, Task task) async {
    await _firestore
        .collection(Constants.usersCollection)
        .doc(userId)
        .collection(Constants.tasksCollection)
        .add({
      'title': task.title,
      'description': task.description,
      'isCompleted': task.isCompleted,
    });
  }

  Future<void> updateTask(String userId, Task task) async {
    await _firestore
        .collection(Constants.usersCollection)
        .doc(userId)
        .collection(Constants.tasksCollection)
        .doc(task.id)
        .update({
      'title': task.title,
      'description': task.description,
      'isCompleted': task.isCompleted,
    });
  }

  Future<void> deleteTask(BuildContext context, String taskId, String userId) async {
    bool deleteConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed deletion
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled deletion
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );

    if (deleteConfirmed == true) {
      await _firestore
          .collection(Constants.usersCollection)
          .doc(userId)
          .collection(Constants.tasksCollection)
          .doc(taskId)
          .delete();
    }
  }


  Future<void> updateTaskCompletion(String userId, String taskId, bool isCompleted) async {
    await _firestore
        .collection(Constants.usersCollection)
        .doc(userId)
        .collection(Constants.tasksCollection)
        .doc(taskId)
        .update({
      'isCompleted': isCompleted,
    });
  }
}
