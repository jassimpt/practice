import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hivepractice/db/model/todomodel.dart';

class TodoService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addTodo(String title, String todos, String uid) async {
    try {
      final TodoModel todo = TodoModel(title: title, todo: todos);
      await firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(title)
          .set(todo.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  deleteTodo(uid, String title) {
    try {
      firestore
          .collection('users')
          .doc(uid)
          .collection('todos')
          .doc(title)
          .delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
