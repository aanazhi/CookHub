//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:pocketbase/pocketbase.dart';
//import 'dart:convert';
//import 'registration.dart';
import 'enter.dart';
//import 'package:http/http.dart' as http;



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
