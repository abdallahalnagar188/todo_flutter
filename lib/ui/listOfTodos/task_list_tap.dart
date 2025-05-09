import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/AppDateUtils.dart';
import 'package:todo_flutter/providers/auth_provider.dart';
import 'package:todo_flutter/providers/tasks_provider.dart';
import 'package:todo_flutter/ui/common/dialog_utils.dart';
import 'package:todo_flutter/ui/listOfTodos/task_item.dart';

import '../../db/models/task.dart';

class TasksListTap extends StatefulWidget {
  const TasksListTap({super.key});

  @override
  State<TasksListTap> createState() => _TasksListTapState();
}

class _TasksListTapState extends State<TasksListTap> {
  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    var tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    var userId = authProvider.firebaseUser?.uid ?? "";
    await tasksProvider.getAllTasks(userId, selectedDate);
  }

  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var tasksProvider = Provider.of<TasksProvider>(context);
    var authProvider = Provider.of<AppAuthProvider>(context);
    var userId = authProvider.firebaseUser?.uid ?? "";

    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: selectedDate,
          onDateChange: (selectDate) {
            setState(() {
              selectedDate = selectDate;
            });
          },
        ),
        Expanded(
          child: FutureBuilder<List<Task>>(
            future: tasksProvider.getAllTasks(userId, selectedDate),
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
                  return TaskItem(
                    task: tasks[index],
                    onTaskDeleteClick: deleteTask,
                    onTaskIsDoneClick: updateToDone,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void deleteTask(Task task) async {
    showLoading(context);

    try {
      var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
      var tasksProvider = Provider.of<TasksProvider>(context, listen: false);
      var userId = authProvider.firebaseUser?.uid ?? "";

      await tasksProvider.deleteTask(userId, task);
      hideLoading(context);
    } catch (e) {
      hideLoading(context);
      showMessage(
        context,
        content: 'Failed to delete task: $e',
        posButtonTitle: "OK",
      );
    }
  }
  void updateToDone(Task task) async {
    try {
      var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
      var tasksProvider = Provider.of<TasksProvider>(context, listen: false);
      var userId = authProvider.firebaseUser?.uid ?? "";

      // Toggle the isDone value
      bool newIsDoneValue = !(task.isDone ?? false);

      await tasksProvider.toDone(userId, task.id ?? "", newIsDoneValue);

      showMessage(
        context,
        content: newIsDoneValue
            ? 'Marked task as done.'
            : 'Marked task as not done.',
        posButtonTitle: 'OK',
      );
    } catch (e) {
      showMessage(
        context,
        content: 'Failed to update task: $e',
        posButtonTitle: 'OK',
      );
    }
  }

}
