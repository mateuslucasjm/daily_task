import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task.dart';

class TaskService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Usuário não logado");
    return user.uid;
  }

  String key(DateTime date) {
    return date.toIso8601String().split('T')[0];
  }

  CollectionReference<Map<String, dynamic>> _tasksRef(DateTime date) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(key(date))
        .collection('items');
  }

  Stream<List<Task>> streamTasks(DateTime date) {
    return _tasksRef(date).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Task.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<List<Task>> loadTasks(DateTime date) async {
    final snapshot = await _tasksRef(date).get();

    return snapshot.docs.map((doc) {
      return Task.fromMap(doc.data(), doc.id);
    }).toList();
  }

  Future<void> addTask(DateTime date, Task task) async {
    await _tasksRef(date).add(task.toMap());
  }

  Future<void> updateTask(DateTime date, Task task) async {
    await _tasksRef(date).doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(DateTime date, String taskId) async {
    await _tasksRef(date).doc(taskId).delete();
  }
}
