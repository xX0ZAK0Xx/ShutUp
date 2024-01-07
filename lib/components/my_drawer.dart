// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shutup/services/auth/auth_service.dart';
import 'package:shutup/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logOut() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //------------------ logo ----------------
              DrawerHeader(
                  child: Center(
                child: Icon(
                  Icons.message,
                  size: 40,
                ),
              )),

              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    // ----------- close the drawer -----------
                    Navigator.of(context).pop();
                  },
                ),
              ),

              //-----------Settings List Tile-------------
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    //----------- close the drawer-----------
                    Navigator.of(context).pop();

                    //----------- Navigate to the Settings page ----------
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                ),
              ),
            ],
          ),
          //--------------- LogOut List Tile --------------------
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("L O G  O U T"),
              leading: Icon(Icons.logout),
              onTap: () {
                //------ close the drawer -----------
                Navigator.of(context).pop();
                //------ Log Out -----------
                logOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
