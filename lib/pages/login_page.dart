// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shutup/services/auth/auth_service.dart';
import 'package:shutup/components/my_button.dart';
import 'package:shutup/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final void Function()? changePage;

  //---------Login---------
  void login(BuildContext context) async {
    //------------- Loading -----------
    showDialog(
        context: context,
        builder: ((context) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.black,
              size: 50,
            ),
          );
        }));
    //---------------- auth service --------------------
    final authService = AuthService();

    //---------------- try Login --------------------
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
      Navigator.of(context).pop();
    }
    //---------------- catch error --------------------
    catch (e) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  LoginPage({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                ),
                //-----------logo-----------
                Icon(
                  Icons.message,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(
                  height: 30,
                ),

                //-----------Welcome Back-----------
                Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("You've been missed", style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 30,
                ),

                //-----------Email TextField-----------
                MyTextField(
                  hintText: "Enter Your Email",
                  controller: _emailController,
                  isPassword: false,
                ),
                SizedBox(
                  height: 10,
                ),
                //-----------Password TextField-----------
                MyTextField(
                  hintText: "Enter Your Password",
                  isPassword: true,
                  controller: _passwordController,
                ),
                SizedBox(
                  height: 20,
                ),
                //-----------Login Button-----------
                MyButton(
                  text: "Log in",
                  ontap: () => login(context),
                ),
                SizedBox(
                  height: 10,
                ),

                //-----------Register Now-----------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member? ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20),
                    ),
                    GestureDetector(
                        onTap: changePage,
                        child: Text(
                          "Register now",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
