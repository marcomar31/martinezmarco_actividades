import 'dart:html';

import 'package:flutter/material.dart';

class ConfiguracionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
      Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16), child:
        Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16), child:
          Center(child:
            Text("ESTA ES LA CONFIGURACIÓN")
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("CONFIGURACIÓN"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(104, 126, 255, 1),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Color.fromRGBO(128, 179, 255, 1),
    );
  }
}