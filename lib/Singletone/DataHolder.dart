import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:martinezmarco_actividades1/Singletone/PlatformAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';
import '../FirestoreObjects/FbUsuario.dart';
import 'FireBaseAdmin.dart';
import 'GeolocAdmin.dart';
import 'HttpAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  String sNombre = "Kyty DataHolder";
  late String sPostTitle;
  FbPost? selectedPost;
  FbUsuario? usuario;
  FirebaseFirestore db = FirebaseFirestore.instance;

  late PlatformAdmin platformAdmin;
  HttpAdmin httpAdmin = HttpAdmin();
  FBAdmin fbAdmin = FBAdmin();
  GeolocAdmin geolocAdmin = GeolocAdmin();

  DataHolder._internal() {
    sPostTitle = "Título de Post";
    platformAdmin = PlatformAdmin();
  }

  factory DataHolder(){
    return _dataHolder;
  }

  void insertPostEnFB (FbPost postNuevo) {
    CollectionReference<FbPost> postsRef = db.collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore, toFirestore: (FbPost post, _) => post.toFirestore());
    postsRef.add(postNuevo);
  }

  void saveSelectedPostInCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fbpost_titulo', selectedPost!.titulo);
    prefs.setString('fbpost_cuerpo', selectedPost!.cuerpo);
  }

  Future<FbPost?> loadCachedFbPost() async {
    if(selectedPost != null) return selectedPost;

    await Future.delayed(const Duration(seconds: 5));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpostTitulo = prefs.getString('fbpost_titulo');
    fbpostTitulo ??= "";

    String? fbpostCuerpo = prefs.getString('fbpost_cuerpo');
    fbpostCuerpo ??= "";

    print("SHARED PREFERENCES --> $fbpostTitulo");
    selectedPost = FbPost(titulo: fbpostTitulo, cuerpo: fbpostCuerpo);

    return selectedPost;
  }

  void suscribeACambiosGPSUsuario(){
    geolocAdmin.registrarCambiosLoc(posicionDelMovilCambio);
  }

  void posicionDelMovilCambio(Position? position) {
    if (usuario != null && position != null) {
      usuario!.geoloc = GeoPoint(position.latitude, position.longitude);
      fbAdmin.actualizarPerfilUsuario(usuario!);
    } else {
      print("Error: Usuario o posición es null. No se puede actualizar la ubicación.");
    }
  }

  Future<FbUsuario?> loadFbUsuario() async {
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference<FbUsuario> ref = db.collection("Usuarios")
          .doc(uid)
          .withConverter(
        fromFirestore: FbUsuario.fromFirestore,
        toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),
      );

      DocumentSnapshot<FbUsuario> docSnap = await ref.get();
      usuario = docSnap.data();
      return usuario;
    } else {
      print("Usuario no autenticado");
      return null;
    }
  }


}