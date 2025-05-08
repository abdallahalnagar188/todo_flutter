import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/db/collections/tasks_collection.dart';
import 'package:todo_flutter/providers/auth_provider.dart';
import 'package:todo_flutter/ui/listOfTodos/task_item.dart';

import '../../db/models/task.dart';

class TaskslistTap extends StatefulWidget {
  const TaskslistTap({super.key});

  @override
  State<TaskslistTap> createState() => _TaskslistTapState();
}

class _TaskslistTapState extends State<TaskslistTap> {
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _tasksFuture = _fetchTasks();
  }

  Future<List<Task>> _fetchTasks() async {
    final authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    final userId = authProvider.firebaseUser?.uid ?? "";
    return await TasksCollection().getAllTasks(userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tasks found.'));
        }

        var tasks = snapshot.data!;
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return TaskItem(task: tasks[index]);
          },
        );
      },
    );
  }
}
