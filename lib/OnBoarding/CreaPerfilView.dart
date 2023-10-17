import 'package:flutter/material.dart';

class CreaPerfilView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("CREA TU PERFIL"),
        centerTitle: true,
        shadowColor: Colors.blue,
        backgroundColor: Colors.greenAccent.withOpacity(0.4),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.tealAccent,
    );
  }

}