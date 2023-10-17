import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Actividades1App.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Actividades1());
}
