// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shutup/auth/auth_service.dart';
import 'package:shutup/components/my_button.dart';
import 'package:shutup/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final void Function()? changePage;

  //---------Register---------
  void register(BuildContext context) async {
    final _auth = AuthService();

    //---------------- If Password matches ----------------------
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await _auth.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      } //---------------- catch error --------------------
      catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }else{
      showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Passwords dont match"),
                ));
    }
  }

  RegisterPage({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              "Welcome",
              style: TextStyle(fontSize: 20),
            ),
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
              height: 10,
            ),
            //-----------Password TextField-----------
            MyTextField(
              hintText: "Confirm Password",
              isPassword: true,
              controller: _confirmPasswordController,
            ),
            SizedBox(
              height: 20,
            ),
            //-----------Login Button-----------
            MyButton(
              text: "Register",
              ontap: () => register(context),
            ),
            SizedBox(
              height: 10,
            ),

            //-----------Register Now-----------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member? ",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
                GestureDetector(
                    onTap: changePage,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ],
        ),
      )),
    );
  }
}
