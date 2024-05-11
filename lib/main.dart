import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamelovers/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gamelovers/widget_tree.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamelovers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WidgetTree(),
    );
  }
}