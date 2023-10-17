import 'package:flutter/material.dart';

import '../Custom/CustomTextField.dart';

class CreaPerfilView extends StatelessWidget {
  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEdad = TextEditingController();
  TextEditingController tecAltura = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body:
        Column(children: [
          //NOMBRE
          Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: CustomTextField(tec: tecNombre, hintText: 'Escriba su nombre',),
          ),

          //EDAD
          Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: CustomTextField(tec: tecEdad, hintText: 'Escriba su edad',),
          ),

          //ALTURA
          Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: CustomTextField(tec: tecAltura, hintText: 'Escriba su altura',),
          ),

          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //Botón aceptar
            Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextButton(
                onPressed: () {},
                child: Text("ACEPTAR")
                ,)
              ,),
            //Botón cancelar
            Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextButton(
                onPressed: () {},
                child: Text("CANCELAR")
                ,)
              ,)
          ],)
        ],),
      appBar: AppBar(
        title: const Text("CREAR PERFIL"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(104, 126, 255, 1),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color.fromRGBO(128, 179, 255, 1),
    );
  }

}