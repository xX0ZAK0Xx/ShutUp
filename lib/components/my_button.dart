// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final text;
  final void Function()? ontap;
  const MyButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
