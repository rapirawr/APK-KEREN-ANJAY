import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [
    Task(title: 'Tugas Kalkulus', subject: 'Matematika', dueDate: DateTime.now().add(const Duration(days: 3))),
    Task(title: 'Presentasi Proyek', subject: 'Pemrograman Web', dueDate: DateTime.now().add(const Duration(days: 7))),
    Task(title: 'Rangkuman Sejarah', subject: 'Sejarah', dueDate: DateTime.now().add(const Duration(days: 1))),
  ];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }
}