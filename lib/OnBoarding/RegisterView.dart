import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Custom/CustomTextField.dart';

class RegisterView extends StatelessWidget {

  late BuildContext _context;
  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  TextEditingController tecRepassword = TextEditingController();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(body: Column(children: [
      const Padding(padding: EdgeInsets.fromLTRB(50, 30, 50, 10),
        child: Text("NECESITARÁS CREAR TUS CREDENCIALES PARA POSTERIORMENTE ACCEDER"),
      ),

      // USUARIO
      ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 450,
        ),
        child: Container(
          width: screenWidth * 0.6,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: CustomTextField(tec: tecUsername, hintText: 'Escriba su usuario'),
        ),
      ),

      // CONTRASEÑA
      ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 450,
        ),
        child: Container(
          width: screenWidth * 0.6,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: CustomTextField(tec: tecPassword, blIsPassword: true, hintText: 'Escriba su contraseña'),
        ),
      ),

      // CONFIRMAR CONTRASEÑA
      ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 450,
        ),
        child: Container(
          width: screenWidth * 0.6,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: CustomTextField(tec: tecRepassword, blIsPassword: true, hintText: 'Repita su contraseña'),
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //Botón registrar
        Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: TextButton(
            onPressed: onClickRegistrar,
            child: const Text("REGISTRAR")
            ,)
          ,),
        //Botón cancelar
        Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: TextButton(
            onPressed: onClickCancelar,
            child: const Text("CANCELAR")
            ,)
          ,)
      ],)
    ],),
      appBar: AppBar(
        title: const Text("REGISTRAR"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(104, 126, 255, 1),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromRGBO(128, 179, 255, 1),
    );
  }

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  void onClickRegistrar() async {
    if (tecPassword.text == tecRepassword.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: tecUsername.text.toLowerCase(),
          password: tecPassword.text,
        );
        ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(content: Text("Usuario registrado con éxito!")));
        Future.delayed(const Duration(seconds: 6), () {
          Navigator.of(_context).popAndPushNamed("/loginview");
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(content: Text("Las contraseñas es demasiado débil")));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(content: Text("El email ya está en uso")));
        }
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(content: Text("Las contraseñas no coinciden")));
    }
  }
}