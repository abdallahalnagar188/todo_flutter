import 'package:flutter/material.dart';
import 'package:todo_flutter/AppDateUtils.dart';
import 'package:todo_flutter/db/collections/tasks_collection.dart';

import '../db/models/task.dart';

class TasksProvider extends ChangeNotifier {
  var tasksCollection = TasksCollection();

  Future<List<Task>> getAllTasks(String userId,DateTime selectedDate ) async {
    var tasksList = await tasksCollection.getAllTasks(userId,selectedDate.dateOnly());
    return tasksList;
  }

  Future<void> addTask(String userId, Task task) async {
    await tasksCollection.createTask(userId, task);
    notifyListeners();
    return;
  }

  Future<void> deleteTask(String userId, Task task) async {
    await tasksCollection.removeTask(userId, task);
    notifyListeners();
    return;
  }

  Future<void> toDone(String userId, String taskId, bool isDone) async {
    await tasksCollection.markTaskAsDone(userId, taskId, isDone);
    notifyListeners();
  }

}
