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

  Future<List<Task>> getAllTasks(String userId) async {
    var querySnapshot = await getTasksCollection(userId).get();
    var taskList =querySnapshot.docs.map((e) => e.data()).toList();
    return taskList;
  }
}
