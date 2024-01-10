import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivepractice/db/model/studentmodel.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
Future<void> addStudents(StudentModel student) async {
  final studentDb = await Hive.openBox<StudentModel>('studentdb');
  await studentDb.add(student);
  studentListNotifier.value.add(student);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDb = await Hive.openBox<StudentModel>('studentdb');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDb.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(index) async {
  final studentDb = await Hive.openBox<StudentModel>('studentdb');
  studentDb.delete(index);
  studentListNotifier.value.removeAt(index);
  studentListNotifier.notifyListeners();
}
