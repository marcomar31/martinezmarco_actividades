import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  String hintText;
  TextEditingController tec;
  bool blIsPassword;

  // Constructor que acepta el hintText como parámetro
  CustomTextField({Key? key,
    this.hintText="",
    required this.tec,
    this.blIsPassword = false,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: tec,
      decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            hintText: hintText,
      ),
      obscureText: blIsPassword,
    );
  }

}