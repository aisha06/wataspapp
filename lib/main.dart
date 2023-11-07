import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:watsap_app/firebase_options.dart';

import 'package:watsap_app/views/loginscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'watsap demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Loginscreen(),
    );
  }
}
