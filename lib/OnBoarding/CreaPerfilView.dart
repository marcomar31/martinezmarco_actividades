import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Custom/CustomTextField.dart';
import '../FirestoreObjects/FbUsuario.dart';

class CreaPerfilView extends StatelessWidget {
  late BuildContext _context;

  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEdad = TextEditingController();
  TextEditingController tecAltura = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _context = context;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          // NOMBRE
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 450,
            ),
            child: Container(
              width: screenWidth * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: CustomTextField(tec: tecNombre, hintText: 'Escriba su nombre'),
            ),
          ),

          // EDAD
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 450,
            ),
            child: Container(
              width: screenWidth * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: CustomTextField(tec: tecEdad, hintText: 'Escriba su edad'),
            ),
          ),

          // ALTURA
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 450,
            ),
            child: Container(
              width: screenWidth * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: CustomTextField(
                  tec: tecAltura, hintText: 'Escriba su altura'),
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
              // Botón cancelar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextButton(
                  onPressed: onClickCancelar,
                  child: Text("CANCELAR"),
                ),
              ),
            ],
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("CREAR PERFIL"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(104, 126, 255, 1),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color.fromRGBO(128, 179, 255, 1),
    );
  }

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  void onClickAceptar() {
    bool excepcion = false;
    FbUsuario usuario = FbUsuario(nombre: tecNombre.text, edad: int.parse(tecEdad.text), altura: double.parse(tecAltura.text), geoloc: GeoPoint(0,0));
    try {
      //UID del usuario que está logeado
      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
      db.collection('Usuarios').doc(uidUsuario).set(usuario.toFirestore());
    } on Exception {
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Se ha producido un error al completar el perfil del usuario")));
      excepcion = true;
    }
    if (!excepcion) {
      Navigator.of(_context).popAndPushNamed("/homeview");
    }
  }
}
