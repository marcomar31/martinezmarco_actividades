import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Custom/CustomTextField.dart';

class RegisterView extends StatelessWidget {

  late BuildContext _context;
  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  TextEditingController tecRepassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;

    return Scaffold(body: Column(children: [
      //USUARIO
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: CustomTextField(tec: tecUsername, hintText: 'Escriba su usuario',),
      ),

      //CONTRASEÑA
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: CustomTextField(tec: tecPassword, blIsPassword: true, hintText: 'Escriba su contraseña',),

      ),

      //CONFIRMAR CONTRASEÑA
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: CustomTextField(tec: tecRepassword, blIsPassword: true, hintText: 'Repita su contraseña',),
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
    ],),
      appBar: AppBar(
        title: const Text("REGISTRAR"),
        centerTitle: true,
        shadowColor: Colors.blue,
        backgroundColor: Colors.greenAccent.withOpacity(0.4),
        automaticallyImplyLeading: false,
      ),
    );
  }

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  void onClickRegistrar() async {
    if (tecPassword.text == tecRepassword.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text,
        );
        ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Usuario registrado con éxito!")));
        Future.delayed(Duration(seconds: 6), () {
          Navigator.of(_context).popAndPushNamed("/loginview");
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Las contraseñas es demasiado débil")));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("El email ya está en uso")));
        }
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Las contraseñas no coinciden")));
    }

  }
}