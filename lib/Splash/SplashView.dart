import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FirestoreObjects/FbUsuario.dart';
import '../Singletone/DataHolder.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
  }

  void checkSession() async {
    await Future.delayed(const Duration(seconds: 4));
    if (FirebaseAuth.instance.currentUser != null) {

      FbUsuario? usuario = await DataHolder().loadFbUsuario();
      await DataHolder().geolocAdmin.determinePosition();
      DataHolder().suscribeACambiosGPSUsuario();

      if (usuario!=null) {
        Navigator.of(context).popAndPushNamed("/homeview");
      } else {
        Navigator.of(context).popAndPushNamed("/creaperfilview");
      }
    } else {
      Navigator.of(context).popAndPushNamed("/loginview");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.catching_pokemon, size: 200),
            Padding(padding: EdgeInsets.all(30)),
            CircularProgressIndicator(),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(128, 179, 255, 1),
    );
  }
}


