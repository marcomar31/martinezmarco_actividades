import 'package:flutter/material.dart';
import 'package:martinezmarco_actividades1/OnBoarding/LoginView.dart';

class Actividades1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MaterialApp materialApp = MaterialApp(title: "Actividades 1",
      initialRoute: '/loginview',
      routes: {
        '/loginview': (context) => LoginView(),
      },
    );
    return materialApp;
  }

}