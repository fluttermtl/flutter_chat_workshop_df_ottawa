// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final controller = TextEditingController();

  final stream = FirebaseFirestore.instance
      .collection('chat')
      .orderBy('time', descending: true)
      .snapshots();

  void sendMessage(String message) {
    if (message.isEmpty) {
      return;
    }

    FirebaseFirestore.instance.collection('chat').add({
      'name': userId,
      'message': message,
      'time': DateTime.now().millisecondsSinceEpoch,
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                final chatList = ChatData.parseChatList(snapshot);
                return ListView.builder(
                  reverse: true,
                  itemCount: chatList.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Text(chatList[index].time.formatted),
                    title: Text(chatList[index].message),
                    subtitle: Text(chatList[index].name),
                  ),
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
