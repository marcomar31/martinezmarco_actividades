import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {

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

      //CONFIRMAR CONTRASEÑA
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Repita su contraseña',
          ),
          obscureText: true,
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //Botón registrar
        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: TextButton(
            onPressed: onClickRegistrar,
            child: Text("REGISTRAR")
            ,)
          ,),
        //Botón cancelar
        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: TextButton(
            onPressed: onClickCancelar,
            child: Text("CANCELAR")
            ,)
          ,)
      ],)
    ],);

    Scaffold scaffold = Scaffold(body: column,);

    return scaffold;
  }

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  void onClickRegistrar() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: tecUsername.text,
        password: tecPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}