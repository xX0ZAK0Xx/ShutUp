import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shutup/components/my_textfield.dart';
import 'package:shutup/services/auth/auth_service.dart';
import 'package:shutup/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, required this.receiverEmail, required this.receiverID});
  final String receiverEmail;
  final String receiverID;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controler
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  // textField Focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // Cause a delay so that the keyboard has time to show up
        // then the amount of remaining space will be calculated
        // then scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    // wait a bit for listView to build
    Future.delayed(
      const Duration(microseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll control
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }

  //send messages
  void sendMessage() async {
    //if there is something inside the textFeild
    if (_messageController.text.isNotEmpty) {
      //send the message
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      //clear the controller
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
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
        stream: _chatService.getMessage(widget.receiverID, senderID),
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
            shrinkWrap: true,
            controller: _scrollController,
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
              focusNode: myFocusNode,
                hintText: "Type a message",
                controller: _messageController,
                isPassword: false)),

        //send button
        IconButton(onPressed: sendMessage, icon: Icon(Icons.send)),
      ],
    );
  }
}
