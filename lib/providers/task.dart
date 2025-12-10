import 'package:flutter/material.dart';

class Task {
  final String id;
  String description;
  DateTime? dueDate;
  TimeOfDay? dueTime;
  bool isDone;

  Task({
    required this.id,
    required this.description,
    this.dueDate,
    this.dueTime,
    this.isDone = false,
  });
}

class TaskProvider with ChangeNotifier {
  final List<Task> _toDoList = [
    Task(
      id: 'task#1',
      description: 'Create my models',
      dueDate: DateTime.now(),
      dueTime: TimeOfDay.now(),
    ),
    Task(
      id: 'task#2',
      description: 'Add provider',
      dueDate: DateTime.now(),
      dueTime: TimeOfDay.now(),
    ),
  ];

  List<Task> get itemsList => _toDoList;

  Task getById(String id) {
    return _toDoList.firstWhere((task) => task.id == id);
  }

  void createNewTask(Task task) {
    final newTask = Task(
      id: task.id,
      description: task.description,
      dueDate: task.dueDate,
      dueTime: task.dueTime,
    );
    _toDoList.add(newTask);
    notifyListeners();
  }

  void editTask(Task task) {
    removeTask(task.id);
    createNewTask(task);
  }

  void removeTask(String id) {
    _toDoList.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void changeStatus(String id) {
    int index = _toDoList.indexWhere((task) => task.id == id);
    _toDoList[index].isDone = !_toDoList[index].isDone;
    notifyListeners();
  }
}
