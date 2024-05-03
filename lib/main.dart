import 'package:flutter/material.dart';
import 'enter.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor:  const Color.fromARGB(255, 148, 205, 120),
      ),
      home:  MyHomePage(),
    );
  }
}
