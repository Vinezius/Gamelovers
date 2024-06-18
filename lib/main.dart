import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamelovers/auth.dart';
import 'package:gamelovers/pages/repository/user_repository.dart';
import 'package:gamelovers/widget_tree.dart';
import 'package:gamelovers/pages/repository/reviews_repository.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
runApp(
    MultiProvider(
      providers: [
        Provider<Auth>(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider<ReviewsRepository>(
          create: (context) => ReviewsRepository(
            auth: context.read<Auth>(),
          ),
        ),
        Provider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
      home: const WidgetTree(),
    );
  }
}