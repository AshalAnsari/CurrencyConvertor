import 'package:flutter/material.dart';

Widget textInputFeild(
    TextEditingController? _controller, String? text, IconData? icon) {
  return TextField(
    controller: _controller,
    style: TextStyle(color: Colors.white, fontSize: 23),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
      border: OutlineInputBorder(),
      prefixIcon: Icon(icon),
      prefixIconColor: Colors.white,
    ),
    keyboardType: TextInputType.text,
  );
}
