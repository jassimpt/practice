import 'package:flutter/material.dart';
import 'package:hivepractice/db/model/namesmodel.dart';
import 'package:hivepractice/service/namesservice.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  TextEditingController namecontroller = TextEditingController();
  NameService nameService = NameService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preference'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: namecontroller,
              decoration: const InputDecoration(
                  hintText: 'Enter anything', border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                addName();
              },
              child: const Text('add data')),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: nameService.fetchNames(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final names = snapshot.data![index];
                      return ListTile(
                        title: Text(names.name!),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                nameService.deleteName(names.id!);
                              });
                            },
                            icon: Icon(Icons.delete)),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  addName() {
    NamesModel names = NamesModel(name: namecontroller.text);
    nameService.postName(names);
    setState(() {
      nameService.fetchNames();
    });
  }
}
