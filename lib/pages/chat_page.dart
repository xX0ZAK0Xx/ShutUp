import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.receiverEmail});
  final String receiverEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(receiverEmail),),
    );
  }
}