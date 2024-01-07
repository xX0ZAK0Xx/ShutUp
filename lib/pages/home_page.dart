// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:shutup/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logOut() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          //------------ Log out button -------------
          IconButton(onPressed: logOut, icon: Icon(Icons.logout, color:  Colors.white,)),
        ],
      ),
    );
  }
}
