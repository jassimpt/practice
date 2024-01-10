import 'package:flutter/material.dart';
import 'package:hivepractice/db/functions/dbfunctions.dart';
import 'package:hivepractice/db/model/studentmodel.dart';

class AddWidget extends StatelessWidget {
  AddWidget(
      {super.key, required this.namecontroller, required this.placecontroller});
  TextEditingController namecontroller;
  TextEditingController placecontroller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        'Add Student',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        TextFormField(
          controller: namecontroller,
          decoration:
              InputDecoration(border: OutlineInputBorder(), hintText: 'name'),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: placecontroller,
          decoration:
              InputDecoration(border: OutlineInputBorder(), hintText: 'place'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  addStudent(context);
                },
                child: Text('Submit')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel')),
          ],
        )
      ],
    );
  }

  addStudent(context) {
    final name = namecontroller.text.trim();
    final place = placecontroller.text.trim();
    if (name.isNotEmpty && place.isNotEmpty) {
      StudentModel student = StudentModel(name: name, place: place);
      addStudents(student);
      Navigator.pop(context);
    }
    return;
  }
}
