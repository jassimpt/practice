import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivepractice/controller/todocontroller.dart';
import 'package:hivepractice/db/model/studentmodel.dart';
import 'package:hivepractice/firebase%20views/mainpage.dart';
import 'package:hivepractice/firebase_options.dart';
import 'package:hivepractice/views/apinames.dart';

import 'package:hivepractice/views/homescreen.dart';
import 'package:hivepractice/firebase%20views/registerscreen.dart';
import 'package:hivepractice/views/sharedscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Hive',
        home: MainPage(),
      ),
    );
  }
}
