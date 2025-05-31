import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tasks/models/task.dart';

class TaskService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Task>> getTasksStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return const Stream.empty();

    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .orderBy('dueDate')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList());
  }

  Future<void> addTask(Task task) async {
    await _firestore.collection('tasks').add(task.toFirestore());
    notifyListeners(); // Notify listeners after modification
  }

  Future<void> updateTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toFirestore());
    notifyListeners(); // Notify listeners after modification
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
    notifyListeners(); // Notify listeners after modification
  }

  Future<List<Task>> getTasksForDate(DateTime date) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return [];

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final snapshot = await _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where('dueDate', isGreaterThanOrEqualTo: startOfDay)
        .where('dueDate', isLessThanOrEqualTo: endOfDay)
        .orderBy('dueDate')
        .get();

    return snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
  }
}