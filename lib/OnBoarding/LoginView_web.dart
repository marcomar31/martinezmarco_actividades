import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:martinezmarco_actividades1/Custom/CustomTextField.dart';

import '../FirestoreObjects/FbUsuario.dart';
import '../Singletone/DataHolder.dart';

class LoginView_web extends StatelessWidget {
  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  LoginView_web({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(50, 30, 50, 10),
            child: Text("POR FAVOR, INTRODUZCA SUS CREDENCIALES PARA ACCEDER"),
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

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón aceptar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextButton(
                  onPressed: onClickAceptar,
                  child: const Text("ACEPTAR"),
                ),
              ),
              // Botón registrar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextButton(
                  onPressed: onClickRegistrar,
                  child: const Text("REGISTRAR"),
                ),
              ),
            ],
          )
        ],
      ),
      appBar: AppBar(
        title: const Text("LOGIN"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(104, 126, 255, 1),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromRGBO(128, 179, 255, 1),
    );
  }

  void onClickRegistrar() {
    Navigator.of(_context).popAndPushNamed('/registerview');
  }

  void onClickAceptar() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: tecUsername.text.toLowerCase(),
        password: tecPassword.text,
      );

      FbUsuario? usuario = await DataHolder().loadFbUsuario();
      await DataHolder().geolocAdmin.determinePosition();
      DataHolder().suscribeACambiosGPSUsuario();

      if(usuario!=null) {
        Navigator.of(_context).popAndPushNamed('/homeview');
      } else {
        Navigator.of(_context).popAndPushNamed("/perfilview");
      }


      ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(content: Text("Usuario loggeado exitosamente!")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(content: Text("Ese usuario no está registrado")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(content: Text("La contraseña es incorrecta")));
      }
    }
  }
}
