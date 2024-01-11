import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedScreen extends StatefulWidget {
  const SharedScreen({super.key});

  @override
  State<SharedScreen> createState() => _SharedScreenState();
}

class _SharedScreenState extends State<SharedScreen> {
  TextEditingController namecontroller = TextEditingController();
  List<String> datas = [];

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      datas = prefs.getStringList('datalist') ?? [];
    });
  }

  void saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('datalist', datas);
  }

  void addData(String data) async {
    setState(() {
      datas.add(data);
      namecontroller.clear();
      saveData();
    });
  }

  void deleteData(int index) {
    setState(() {
      datas.removeAt(index);
      saveData();
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
                addData(namecontroller.text);
              },
              child: const Text('add data')),
          const SizedBox(
            height: 20,
          ),
          datas.isEmpty
              ? const Center(
                  child: Text('No data available'),
                )
              : Expanded(
                  child: ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(datas[index]),
                      trailing: IconButton(
                          onPressed: () {
                            deleteData(index);
                          },
                          icon: const Icon(Icons.delete)),
                    );
                  },
                ))
        ],
      ),
    );
  }
}
