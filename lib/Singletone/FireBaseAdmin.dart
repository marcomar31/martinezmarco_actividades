import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:martinezmarco_actividades1/FirestoreObjects/FbUsuario.dart';

class FBAdmin{

  FirebaseFirestore db = FirebaseFirestore.instance;

  FBAdmin(){

  }

  Future<FbUsuario?> descargarPerfil(String? idPerfil) async {
    final docRef = db.collection("Usuarios").doc(idPerfil)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
      toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),
    );


    final docSnap = await docRef.get();
    return docSnap.data();
  }
}