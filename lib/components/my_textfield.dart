import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final FocusNode? focusNode;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isPassword, this.focusNode, 
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isObscured = true; // Initialize _isObscured here

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword; // Access widget in initState
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        focusNode: widget.focusNode,
        obscureText: _isObscured,
        controller: widget.controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          suffixIcon: widget.isPassword
              ? Container(
                  margin: EdgeInsets.all(10),
                  child: IconButton(
                    icon: _isObscured
                        ? const Icon(
                            Icons.visibility_off,
                            color: Color.fromARGB(255, 134, 134, 134),
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 134, 134, 134),
                          ),
                    onPressed: () => setState(() => _isObscured = !_isObscured),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
