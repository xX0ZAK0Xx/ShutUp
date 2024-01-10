// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shutup/services/auth/auth_service.dart';
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
    final _auth = AuthService();

    //---------------- If Password matches ----------------------
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await _auth.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
        Navigator.of(context).pop();
      } //---------------- catch error --------------------
      catch (e) {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
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
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
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
      ),
    );
  }
}
