import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:martinezmarco_actividades1/Custom/CustomTextField.dart';

import '../FirestoreObjects/FbUsuario.dart';

class LoginView extends StatelessWidget {
  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _context = context;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(50, 30, 50, 10),
            child: Text("POR FAVOR, INTRODUZCA SUS CREDENCIALES PARA ACCEDER"),
          ),
          // USUARIO
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 450,
            ),
            child: Container(
              width: screenWidth * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: CustomTextField(tec: tecUsername, hintText: 'Escriba su usuario'),
            ),
          ),

          // CONTRASEÑA
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 450,
            ),
            child: Container(
              width: screenWidth * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: CustomTextField(tec: tecPassword, blIsPassword: true, hintText: 'Escriba su contraseña'),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón aceptar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextButton(
                  onPressed: onClickAceptar,
                  child: Text("ACEPTAR"),
                ),
              ),
              // Botón registrar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextButton(
                  onPressed: onClickRegistrar,
                  child: Text("REGISTRAR"),
                ),
              ),
            ],
          )
        ],
      ),
      appBar: AppBar(
        title: const Text("LOGIN"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(104, 126, 255, 1),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color.fromRGBO(128, 179, 255, 1),
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
      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference<FbUsuario> ref = db.collection("Usuarios").doc(uidUsuario).withConverter(
        fromFirestore: FbUsuario.fromFirestore,
        toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),
      );

      DocumentSnapshot<FbUsuario> docSnap = await ref.get();
      if (docSnap.exists) {
        FbUsuario usuario = docSnap.data()!;
        if (usuario != null) {
          Navigator.of(_context).popAndPushNamed('/homeview');
        }
      } else {
        Navigator.of(_context).popAndPushNamed("/creaperfilview");
      }
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Usuario loggeado exitosamente!")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Ese usuario no está registrado")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("La contraseña es incorrecta")));
      }
    }
  }
}
