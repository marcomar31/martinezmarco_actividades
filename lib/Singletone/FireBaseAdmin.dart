import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:martinezmarco_actividades1/FirestoreObjects/FbUsuario.dart';

import '../FirestoreObjects/FbPost.dart';

class FBAdmin{

  FirebaseFirestore db = FirebaseFirestore.instance;

  FBAdmin();

  Future<FbUsuario?> descargarPerfil(String? idPerfil) async {
    final docRef = db.collection("Usuarios").doc(idPerfil)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
      toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),
    );


    final docSnap = await docRef.get();
    return docSnap.data();
  }

  Future<List<FbPost>> buscarPostsPorTitulo(String textoBusqueda) async {
    try {
      final querySnapshot = await db
          .collection("Posts")
          .where('titulo', isGreaterThanOrEqualTo: textoBusqueda.toUpperCase())
          .get();

      List<FbPost> posts = [];

      for (var doc in querySnapshot.docs) {
        var post = FbPost.fromFirestore(doc, null);
        posts.add(post);
      }

      return posts;
    } catch (e) {
      print("Error al buscar posts: $e");
      return [];
    }
  }

}