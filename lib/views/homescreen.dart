import 'package:flutter/material.dart';
import 'package:hivepractice/db/functions/dbfunctions.dart';
import 'package:hivepractice/db/model/studentmodel.dart';
import 'package:hivepractice/views/widgets/addwidget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController placecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddWidget(
                  namecontroller: namecontroller,
                  placecontroller: placecontroller,
                );
              },
            );
          },
          child: Icon(Icons.add)),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext context, List<StudentModel> student, Widget? child) {
          return ListView.builder(
            itemCount: student.length,
            itemBuilder: (context, index) {
              final studentdata = student[index];
              return ListTile(
                leading: CircleAvatar(),
                title: Text(
                  studentdata.name!,
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(studentdata.place!),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            deleteStudent(index);
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
