import 'package:flutter/material.dart';
import 'package:martinezmarco_actividades1/Main/ConfiguracionView.dart';
import 'package:martinezmarco_actividades1/OnBoarding/LoginView.dart';
import 'package:martinezmarco_actividades1/OnBoarding/RegisterView.dart';
import 'package:martinezmarco_actividades1/Splash/SplashView.dart';
import 'Main/HomeView.dart';
import 'OnBoarding/CreaPerfilView.dart';
import 'Singletone/DataHolder.dart';

class Actividades1 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    MaterialApp materialAppMobile = const MaterialApp();
    if(DataHolder().platformAdmin.isAndroidPlatform() ||
        DataHolder().platformAdmin.isIOSPlatform()){

      materialAppMobile=MaterialApp(title: "Actividades Marco (Android)",
        initialRoute: '/splashview',
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView(),
          '/creaperfilview': (context) => CreaPerfilView(),
          '/splashview': (context) => SplashView(),
        },
      );
    }
    else if(DataHolder().platformAdmin.isWebPlatform()){
      materialAppMobile = MaterialApp(title: "Actividades Marco (Web)",
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Georgia',
        ),
        initialRoute: '/gestionadministracionview',
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView(),
          '/creaperfilview': (context) => CreaPerfilView(),
          '/splashview': (context) => SplashView(),
          '/gestionadministracionview': (context) => ConfiguracionView(),
        },
      );
    }

    return materialAppMobile;
  }
}