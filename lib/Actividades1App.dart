import 'package:flutter/material.dart';
import 'package:martinezmarco_actividades1/OnBoarding/LoginView.dart';
import 'package:martinezmarco_actividades1/OnBoarding/RegisterView.dart';
import 'package:martinezmarco_actividades1/Splash/SplashView.dart';
import 'Main/HomeView.dart';
import 'OnBoarding/CreaPerfilView.dart';

class Actividades1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MaterialApp materialApp = MaterialApp(title: "Actividades Marco",
      initialRoute: '/loginview',
      routes: {
        '/loginview': (context) => LoginView(),
        '/registerview': (context) => RegisterView(),
        '/homeview': (context) => HomeView(),
        '/creaperfilview': (context) => CreaPerfilView(),
        '/splashview': (context) => SplashView(),
      },
    );
    return materialApp;
  }

}