import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:reward_calculator/constant/theme.dart';
import 'package:reward_calculator/provider/data_provider.dart';
import 'package:reward_calculator/screen/splash_screen.dart';

import 'constant/client_name.dart';
import 'model/reward_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  log(directory.path);
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>(HiveBoxes.todo);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        home: const SplashScreen(),
      ),
    );
  }
}
