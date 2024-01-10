import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shutup/components/my_textfield.dart';
import 'package:shutup/services/auth/auth_service.dart';
import 'package:shutup/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});
  final String receiverEmail;
  final String receiverID;

  //text controler
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send messages
  void sendMessage() async {
    //if there is something inside the textFeild
    if (_messageController.text.isNotEmpty) {
      //send the message
      await _chatService.sendMessage(receiverID, _messageController.text);

      //clear the controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //----- all messagess---------
          Expanded(child: _buildMessageList(context)),

          //----- user input -----------
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessage(receiverID, senderID),
        builder: ((context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading....");
          }

          //return List View
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc, context))
                .toList(),
          );
        }));
  }

  Widget _buildMessageItem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data["senderID"] == _authService.getCurrentUser()!.uid;

    return BubbleSpecialThree(
      text: data["message"],
      color: Theme.of(context).colorScheme.secondary,
      tail: true,
      isSender: isCurrentUser,
    );
  }

  // build user input
  Widget _buildUserInput() {
    return Row(
      children: [
        //textfield should take up the rest of the space
        Expanded(
            child: MyTextField(
                hintText: "Type a message",
                controller: _messageController,
                isPassword: false)),

        //send button
        IconButton(onPressed: sendMessage, icon: Icon(Icons.send)),
      ],
    );
  }
}
