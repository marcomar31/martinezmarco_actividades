import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;
  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;

    Column column = new Column(children: [
      //USUARIO
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: TextField(
          controller: tecUsername,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escriba su usuario',
          ),
        ),
      ),

      //CONTRASEÑA
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: TextField(
          controller: tecPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escriba su contraseña',
          ),
          obscureText: true,
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //Botón aceptar
        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: TextButton(
            onPressed: onClickAceptar,
            child: Text("ACEPTAR")
          ,)
        ,),
        //Botón registrar
        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: TextButton(
            onPressed: onClickRegistrar,
            child: Text("REGISTRAR")
            ,)
          ,)
      ],)
    ],);

    Scaffold scaffold = Scaffold(body: column,);

    return scaffold;
  }


  void onClickRegistrar() {
    Navigator.of(_context).popAndPushNamed('/registerview');
  }

  void onClickAceptar() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text
      );
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Usuario loggeado exitosamente!")));
      Navigator.of(_context).popAndPushNamed('/homeview');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Ese usuario no está registrado")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Las contraseña es incorrecta")));
      }
    }
  }
}