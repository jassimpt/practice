import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hivepractice/controller/todocontroller.dart';
import 'package:hivepractice/db/model/todomodel.dart';
import 'package:hivepractice/service/authservice.dart';
import 'package:hivepractice/service/todoservice.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final FireAuthService service = FireAuthService();

  final TodoService todoService = TodoService();

  final TextEditingController todocontroller = TextEditingController();

  final TextEditingController titlecontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TodoProvider>(context, listen: false)
        .fetchTodos(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Your Tasks'),
        actions: [
          IconButton(
              onPressed: () {
                service.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add task'),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: titlecontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Title'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: todocontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Task'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              saveTodo();
                              Navigator.pop(context);
                            },
                            child: const Text('Submit')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                      ],
                    )
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add)),
      body: Column(
        children: [
          Consumer<TodoProvider>(
            builder: (context, value, child) => value.todos.isEmpty
                ? const Center(
                    child: Text('Add Something'),
                  )
                : Expanded(
                    child: ListView.builder(
                    itemCount: value.todos.length,
                    itemBuilder: (context, index) {
                      final TodoModel todos = value.todos[index];
                      return ListTile(
                        title: Text(todos.title!),
                        subtitle: Text(todos.todo!),
                        trailing: IconButton(
                            onPressed: () {
                              todoService.deleteTodo(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  todos.title!);
                            },
                            icon: const Icon(Icons.delete)),
                      );
                    },
                  )),
          )
        ],
      ),
    );
  }

  saveTodo() {
    final todo = todocontroller.text;
    final title = titlecontroller.text;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    todoService.addTodo(title, todo, uid);
  }
}
