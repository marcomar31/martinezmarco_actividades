import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  String hintText;
  TextEditingController tec;
  bool blIsPassword;
  double dPaddingH;
  double dPaddingV;

  // Constructor que acepta el hintText como parámetro
  CustomTextField({Key? key,
    this.hintText="",
    required this.tec,
    this.blIsPassword = false,
    this.dPaddingH = 60,
    this.dPaddingV = 15,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: tec,
      decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
      ),
      obscureText: blIsPassword,
    );
  }

}