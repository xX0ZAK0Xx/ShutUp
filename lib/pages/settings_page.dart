import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shutup/themes/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"),backgroundColor: Theme.of(context).colorScheme.background, centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // dark mode
            Text("Dark Mode", style: TextStyle(fontSize: 22),),
            //switch
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, 
              onChanged: ((value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme()))
          ],
        ),
      ),
    );
  }
}