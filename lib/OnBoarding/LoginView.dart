import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:martinezmarco_actividades1/Custom/CustomTextField.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;
  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;

    return Scaffold(body: Column(children: [
      Padding(padding: EdgeInsets.fromLTRB(50, 30, 50, 10),
        child: Text("POR FAVOR, INTRODUZCA SUS CREDENCIALES PARA ACCEDER"),
      ),
      //USUARIO
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: CustomTextField(tec: tecUsername, hintText: 'Escriba su usuario',),
      ),

      //CONTRASEÑA
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: CustomTextField(tec: tecPassword, blIsPassword: true, hintText: 'Escriba su contraseña',),
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
    ],),
        appBar: AppBar(
          title: const Text("LOGIN"),
          centerTitle: true,
          shadowColor: Colors.blue,
          backgroundColor: Colors.greenAccent.withOpacity(0.4),
          automaticallyImplyLeading: false,
        ),
      backgroundColor: Colors.tealAccent,
    );
  }


  void onClickRegistrar() {
    Navigator.of(_context).popAndPushNamed('/registerview');
  }

  void onClickAceptar() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUsername.text.toLowerCase(),
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