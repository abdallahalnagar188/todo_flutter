import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_flutter/db/models/task.dart';
import 'package:todo_flutter/AppDateUtils.dart';
import 'package:todo_flutter/ui/common/dialog_utils.dart';

typedef OnTaskDeleteClick = void Function(Task task);

class TaskItem extends StatelessWidget {
  var task = Task();
  OnTaskDeleteClick onTaskDeleteClick;

  TaskItem({super.key, required this.task, required this.onTaskDeleteClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                showMessage(
                  context,
                  content: "are you sure to delete this task ?",
                  posButtonTitle: "confirm",
                  posButtonClick: () {
                    onTaskDeleteClick(task);
                  },
                  negButtonTitle: "cancel",
                );
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: "Delete",
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            height: 100,
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 66,
                  decoration: BoxDecoration(color: Colors.blue),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        task.title ?? "",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(height: 8),

                      Row(
                        children: [
                          Icon(Icons.timer_outlined),
                          Text(
                            "${task.time?.formatTime()}",
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 18),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
