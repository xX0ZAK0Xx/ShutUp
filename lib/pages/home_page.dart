// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:shutup/components/my_drawer.dart';
import 'package:shutup/components/user_tile.dart';
import 'package:shutup/pages/chat_page.dart';
import 'package:shutup/services/auth/auth_service.dart';
import 'package:shutup/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //----------- chat and auth services --------------------
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "Home Page",
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  // build a lift of users except for the current user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //-------- error --------
          if (snapshot.hasError) {
            return const Text("Error");
          }
          //-------- loading --------
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading....");
          }
          //-------- Return List View -----------
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  // build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          // tapped on a user -> go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData["email"], receiverID: userData['uid'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
