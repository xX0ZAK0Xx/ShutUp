import 'package:flutter/material.dart';
import 'package:shutup/pages/login_page.dart';
import 'package:shutup/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isLoginPage = true;
  void togglePage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoginPage
        ? LoginPage(changePage: togglePage,)
        : RegisterPage(changePage: togglePage);
  }
}
