import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:martinezmarco_actividades1/Custom/CustomTextField.dart';

import '../FirestoreObjects/FbUsuario.dart';
import '../Singletone/DataHolder.dart';

class LoginView_mobile extends StatefulWidget {
  const LoginView_mobile({super.key});

  @override
  State<LoginView_mobile> createState() => _LoginView_mobileState();
}

class _LoginView_mobileState extends State<LoginView_mobile> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();
  String sVerificationCode="";
  bool blMostrarVerificacion = false;

  void enviarTelefono_clicked() async {
    String sTelefono=tecPhone.text;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: sTelefono,
      verificationCompleted: verificacionCompletada,
      verificationFailed: verificacionFallida,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void enviarVerificacion_clicked() async {
    String smsCode = tecVerify.text;

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: sVerificationCode, smsCode: smsCode);

    await FirebaseAuth.instance.signInWithCredential(credential);

    FbUsuario? usuario = await DataHolder().loadFbUsuario();
    await DataHolder().geolocAdmin.determinePosition();
    DataHolder().suscribeACambiosGPSUsuario();

    if(usuario!=null){
      Navigator.of(context).popAndPushNamed("/homeview");
    }
    else{
      Navigator.of(context).popAndPushNamed("/perfilview");
    }
  }

  void verificacionCompletada(PhoneAuthCredential credencial) async{
    await FirebaseAuth.instance.signInWithCredential(credencial);

    FbUsuario? usuario = await DataHolder().loadFbUsuario();
    await DataHolder().geolocAdmin.determinePosition();
    DataHolder().suscribeACambiosGPSUsuario();

    if(usuario!=null){
      Navigator.of(context).popAndPushNamed("/homeview");
    }
    else{
      Navigator.of(context).popAndPushNamed("/perfilview");
    }
  }

  void verificacionFallida(FirebaseAuthException error) {
    if (error.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }


  void codeSent(String verificationId, int? forceResendingToken) async {
    sVerificationCode = verificationId;
    setState(() {
      blMostrarVerificacion = true;
    });
  }

  void codeAutoRetrievalTimeout(String verificationId) {

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(50, 30, 50, 10),
          child: Text("POR FAVOR, INTRODUZCA SUS CREDENCIALES PARA ACCEDER"),
        ),
        // NTelefono
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 450,
          ),
          child: Container(
            width: screenWidth * 0.6,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: CustomTextField(tec: tecPhone, hintText: "Número de teléfono"),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botón enviar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextButton(
                onPressed: enviarTelefono_clicked,
                child: const Text("Enviar teléfono"),
              ),
            ),
          ],),

        // NVerificador
        if(blMostrarVerificacion)
          ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 450,
          ),
          child: Container(
            width: screenWidth * 0.6,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: CustomTextField(tec: tecVerify, hintText: "Número verificador"),
          ),
        ),

        if(blMostrarVerificacion)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón enviar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextButton(
                  onPressed: enviarVerificacion_clicked,
                  child: const Text("Enviar verificación"),
                ),
              ),
          ],)
      ],),
      ),
      appBar: AppBar(
        title: const Text("LOGIN"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(104, 126, 255, 1),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromRGBO(128, 179, 255, 1),
    );
  }
}
