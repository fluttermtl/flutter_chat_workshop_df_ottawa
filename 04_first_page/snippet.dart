// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(FlutterChatWorkshopApp());
}

class FlutterChatWorkshopApp extends StatelessWidget {
  const FlutterChatWorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlutterChatPage(),
    );
  }
}

class FlutterChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // TODO 1: Add an AppBar with a title of 'Flutter Chat'
        // TODO 2: Add a Center widget with a Text widget with the text 'Hello, world!'
        // TODO 3: Add a FloatingActionButton with an Icon of Icons.add
        );
  }
}
