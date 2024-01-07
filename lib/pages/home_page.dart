// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:shutup/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.secondary,
        title: Text(
          "Home Page",
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
    );
  }
}
