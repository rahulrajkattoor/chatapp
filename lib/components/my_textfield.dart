import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  final TextEditingController Controller;
  final String hintText;
  final bool obscuretext;
  const textfield({super.key, required this.Controller, required this.hintText, required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: Controller,
      obscureText: obscuretext,
      decoration: InputDecoration(
        hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)
            ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey)

      ),
    );

  }
}
