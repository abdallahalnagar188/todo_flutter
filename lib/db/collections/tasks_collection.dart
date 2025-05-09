import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class TasksCollection {
  CollectionReference<Task> getTasksCollection(userId) {
    var dp = FirebaseFirestore.instance;
    return dp
        .collection("users")
        .doc(userId)
        .collection("tasks")
        .withConverter(
          fromFirestore: (snapshot, options) {
            return Task.fromFiresore(snapshot.data());
          },
          toFirestore: (value, options) {
            return value.toFirestore();
          },
        );
  }

  Future<void> createTask(String userId, Task task) async {
    var docRef = getTasksCollection(userId).doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  Future<List<Task>> getAllTasks(String userId, int selectedDate) async {
    var querySnapshot =
        await getTasksCollection(userId)
            .where("date", isEqualTo: selectedDate)
            .orderBy("time", descending: false)
            .get();
    var taskList = querySnapshot.docs.map((e) => e.data()).toList();
    return taskList;
  }

  Future<void> removeTask(String userId, Task task) {
    var docRef = getTasksCollection(userId).doc(task.id);
    return docRef.delete();
  }

  Future<void> markTaskAsDone(String userId, String taskId, bool isDone) async {
    var docRef = getTasksCollection(userId).doc(taskId);
    await docRef.update({'isDone': isDone});
  }

}
