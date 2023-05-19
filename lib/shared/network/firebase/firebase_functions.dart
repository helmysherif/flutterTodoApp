import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class FireBaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJson(snapshot.data()!),
            toFirestore: (task, _) => task.toJson());
  }

  static Future<void> addTaskToFireStore(TaskModel task) {
    var collection = getTasksCollection();
    var documentRef = collection.doc();
    task.id = documentRef.id;
    return documentRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasksFromFireStore(DateTime date) {
    var collection = getTasksCollection();
    // print(DateUtils.dateOnly(date).microsecondsSinceEpoch);
    return collection
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).microsecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(String id, TaskModel task) {
    return getTasksCollection().doc(id).update(task.toJson());
  }
}
