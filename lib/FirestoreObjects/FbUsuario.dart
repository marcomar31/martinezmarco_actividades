import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario {
  final String nombre;
  final int edad;
  final double altura;
  GeoPoint geoloc;

  FbUsuario({
      required this.nombre,
      required this.edad,
      required this.altura,
      required this.geoloc,
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbUsuario(
        nombre: data?['nombre'] != null ? data!['nombre'] : "",
        edad: data?['edad'] != null ? data!['edad'] : 0,
        altura: data?['altura'] != null ? data!['altura'].toDouble() : 0.0,
        geoloc:data?['geoloc'] != null ? data!['geoloc'] : const GeoPoint(0, 0)
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nombre": nombre,
      "edad": edad,
      "altura": altura,
      "geoloc": geoloc,
    };
  }
}