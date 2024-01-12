import 'package:flutter/material.dart';

class ConfiguracionView extends StatelessWidget {
  const ConfiguracionView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
      const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16), child:
        Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16), child:
          Center(child:
            Text("ESTA ES LA CONFIGURACIÓN")
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("CONFIGURACIÓN"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(104, 126, 255, 1),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: const Color.fromRGBO(128, 179, 255, 1),
    );
  }
}