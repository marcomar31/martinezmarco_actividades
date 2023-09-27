import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Actividades1App.dart';
import 'firebase_options.dart';
void main() {
  runApp(Actividades1());
  initFB();
}

void initFB() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}