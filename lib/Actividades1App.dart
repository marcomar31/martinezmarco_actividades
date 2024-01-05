import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:martinezmarco_actividades1/Main/ConfiguracionView.dart';
import 'package:martinezmarco_actividades1/Main/HomeView_mobile.dart';
import 'package:martinezmarco_actividades1/Main/SearchPostsView.dart';
import 'package:martinezmarco_actividades1/OnBoarding/LoginView_mobile.dart';
import 'package:martinezmarco_actividades1/OnBoarding/LoginView_web.dart';
import 'package:martinezmarco_actividades1/OnBoarding/RegisterView.dart';
import 'package:martinezmarco_actividades1/Splash/SplashView.dart';
import 'Main/HomeView_web.dart';
import 'OnBoarding/CreaPerfilView.dart';
import 'Singletone/DataHolder.dart';

class Actividades1 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    MaterialApp materialAppMobile = const MaterialApp();
    if(DataHolder().platformAdmin.isAndroidPlatform() ||
        DataHolder().platformAdmin.isIOSPlatform()) {
      materialAppMobile = MaterialApp(title: "Actividades Marco (Android)",
        theme:ThemeData(
          textTheme: GoogleFonts.maliTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: '/homeview',
        routes: {
          '/loginview': (context) => LoginView_mobile(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView_mobile(),
          '/creaperfilview': (context) => CreaPerfilView(),
          '/splashview': (context) => SplashView(),
          '/searchpostsview': (context) => SearchPostsView(searchResults: [],),
        },
      );
    }
    else if(DataHolder().platformAdmin.isWebPlatform()) {
      materialAppMobile = MaterialApp(title: "Actividades Marco (Web)",
        theme: ThemeData(
          textTheme: GoogleFonts.anonymousProTextTheme(
            Theme.of(context).textTheme,
          ),
          brightness: Brightness.dark,
          fontFamily: 'Georgia',
        ),
        initialRoute: '/splashview',
        routes: {
          '/loginview': (context) => LoginView_web(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView_web(),
          '/creaperfilview': (context) => CreaPerfilView(),
          '/splashview': (context) => SplashView(),
          '/gestionadministracionview': (context) => ConfiguracionView(),
        },
      );
    }

    return materialAppMobile;
  }
}