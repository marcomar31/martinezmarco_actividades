import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;

    Column column = new Column(children: [
      //USUARIO
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escriba su usuario',
          ),
        ),
      ),

      //CONTRASEÑA
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: TextField(
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
            onPressed: () {  },
            child: Text("REGISTRAR")
            ,)
          ,),
        //Botón cancelar
        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: TextButton(
            onPressed: () {  },
            child: Text("CANCELAR")
            ,)
          ,)
      ],)
    ],);

    Scaffold scaffold = Scaffold(body: column,);

    return scaffold;
  }

}