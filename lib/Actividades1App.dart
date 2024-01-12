import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:martinezmarco_actividades1/Main/ConfiguracionView.dart';
import 'package:martinezmarco_actividades1/Main/HomeView_mobile.dart';
import 'package:martinezmarco_actividades1/Main/MapaView.dart';
import 'package:martinezmarco_actividades1/Main/SearchPostsView.dart';
import 'package:martinezmarco_actividades1/OnBoarding/LoginView_mobile.dart';
import 'package:martinezmarco_actividades1/OnBoarding/LoginView_web.dart';
import 'package:martinezmarco_actividades1/OnBoarding/RegisterView.dart';
import 'package:martinezmarco_actividades1/Splash/SplashView.dart';
import 'Main/HomeView_web.dart';
import 'OnBoarding/CreaPerfilView.dart';
import 'Singletone/DataHolder.dart';

class Actividades1 extends StatelessWidget{
  const Actividades1({super.key});


  @override
  Widget build(BuildContext context) {
    MaterialApp materialAppMobile = const MaterialApp();
    if(DataHolder().platformAdmin.isAndroidPlatform() ||
        DataHolder().platformAdmin.isIOSPlatform()) {
      materialAppMobile = MaterialApp(title: "Actividades Marco (Android)",
        debugShowCheckedModeBanner: false,
        theme:ThemeData(
          textTheme: GoogleFonts.maliTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: '/splashview',
        routes: {
          '/loginview': (context) => const LoginView_mobile(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => const HomeView_mobile(),
          '/creaperfilview': (context) => CreaPerfilView(),
          '/splashview': (context) => const SplashView(),
          '/searchpostsview': (context) => const SearchPostsView(searchResults: [],),
          '/mapaview': (context) => const MapaView(),
        },
      );
    }
    else if(DataHolder().platformAdmin.isWebPlatform()) {
      materialAppMobile = MaterialApp(title: "Actividades Marco (Web)",
        debugShowCheckedModeBanner: false,
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
          '/homeview': (context) => const HomeView_web(),
          '/creaperfilview': (context) => CreaPerfilView(),
          '/splashview': (context) => const SplashView(),
          '/gestionadministracionview': (context) => const ConfiguracionView(),
          '/mapaview': (context) => const MapaView(),
        },
      );
    }

    return materialAppMobile;
  }
}