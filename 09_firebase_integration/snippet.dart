// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final secret = String.fromCharCodes(
  base64Decode('U2VuZCAiRE9ORSIgdG8gdGhlIGNoYXQgYW5kIHJhaXNlIGhhbmQh'),
);

final userId = UniqueKey().toString();

void main() async {
  // DO NOT TOUCH: Firebase configuration
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBFQIi3pNiQNoM4y7dBKxBCp-lzeqSPfg8',
      appId: '1:702148614087:web:7615cf62cdbb20e7c52be2',
      messagingSenderId: '702148614087',
      projectId: 'flutter-chat-aliyazdi',
      authDomain: 'flutter-chat-aliyazdi.firebaseapp.com',
      storageBucket: 'flutter-chat-aliyazdi.appspot.com',
    ),
  );

  runApp(FlutterChatWorkshopApp());
}

class ChatData {
  final String name;
  final String message;
  final DateTime time;

  ChatData({
    required this.name,
    required this.message,
    required this.time,
  });

  factory ChatData.fromJson(Map<String, dynamic> doc) {
    return ChatData(
      name: doc['name'] ?? '',
      message: doc['message'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(doc['time'] as int? ?? 0),
    );
  }

  static List<ChatData> parseChatList(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
  ) {
    return snapshot.data?.docs
            .map((doc) => ChatData.fromJson(doc.data()))
            .toList() ??
        [];
  }
}

extension DateTimeExtension on DateTime {
  String get formatted => DateFormat('hh:mm a').format(this);
}

class FlutterChatWorkshopApp extends StatelessWidget {
  const FlutterChatWorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: FlutterChatPage(),
    );
  }
}

class FlutterChatPage extends StatefulWidget {
  const FlutterChatPage({super.key});

  @override
  State<FlutterChatPage> createState() => _FlutterChatPageState();
}

class _FlutterChatPageState extends State<FlutterChatPage> {
  final messages = <String>[];
  final controller = TextEditingController();

  final stream = FirebaseFirestore.instance
      .collection('chat')
      .orderBy('time', descending: true)
      .snapshots();

  void sendMessage(String message) {
    if (message.isEmpty) {
      return;
    }
    // TODO 1: Send message to Firebase instead of adding to [messages] list
    // Collection name: chat
    // Fields: name: string, message: string, time: int (millisecondsSinceEpoch)
    setState(() {
      messages.add(message);
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            // TODO 2: Use stream instead of [messages] list
            // hint 1: StreamBuilder
            // hint 2: ChatData.parseChatList(snapshot) to parse the snapshot
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('now'),
                  title: Text(messages[messages.length - index - 1]),
                  subtitle: Text('John Doe'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: secret,
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => sendMessage(controller.text),
                ),
              ),
              onSubmitted: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
