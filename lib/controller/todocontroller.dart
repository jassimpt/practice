import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hivepractice/db/model/todomodel.dart';
import 'package:provider/provider.dart';

class TodoProvider extends ChangeNotifier {
  List todos = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  fetchTodos(String uid) async {
    try {
      firestore
          .collection('users')
          .doc(uid)
          .collection('todos')
          .snapshots()
          .listen((todo) {
        todos = todo.docs.map((doc) => TodoModel.fromJson(doc.data())).toList();
        notifyListeners();
      });
      return todos;
    } catch (e) {
      throw Exception(e);
    }
  }
}
