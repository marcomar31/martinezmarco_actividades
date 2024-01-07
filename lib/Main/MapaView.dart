import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../FirestoreObjects/FbUsuario.dart';

class MapaView extends StatefulWidget {
  const MapaView({super.key});

  @override
  State<MapaView> createState() => MapaViewState();
}

class MapaViewState extends State<MapaView> {
  late Position _ubicacionActual;
  late GoogleMapController _controller;
  Set<Marker> marcadores = Set();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final Map<String, FbUsuario> tablaUsuarios = Map();

  late CameraPosition _kUser = CameraPosition(
    bearing: 0,
    target: LatLng(0, 0),
    tilt: 0,
    zoom: 0,
  );

  @override
  void initState() {
    obtenerUbicacionActual();
    suscribirADescargaUsuarios();
    super.initState();
  }

  Future<void> obtenerUbicacionActual() async {
    final posicion = await Geolocator.getCurrentPosition();
    setState(() {
      _ubicacionActual = posicion;
      _kUser = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(
          _ubicacionActual.latitude,
          _ubicacionActual.longitude,
        ),
        tilt: 59.440717697143555,
        zoom: 15.151926040649414,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void suscribirADescargaUsuarios() async {
    CollectionReference<FbUsuario> ref = db.collection("Usuarios")
        .withConverter(
      fromFirestore: FbUsuario.fromFirestore,
      toFirestore: (FbUsuario post, _) => post.toFirestore(),
    );
    ref.snapshots().listen(usuariosDescargados, onError: descargaUsuariosError);
  }

  void usuariosDescargados(QuerySnapshot<FbUsuario> usuariosDescargados) {
    print("NUMERO DE USUARIOS ACTUALIZADOS>>>> " +
        usuariosDescargados.docChanges.length.toString());

    Set<Marker> marcTemp = Set();

    for (int i = 0; i < usuariosDescargados.docChanges.length; i++) {
      FbUsuario temp = usuariosDescargados.docChanges[i].doc.data()!;
      tablaUsuarios[usuariosDescargados.docChanges[i].doc.id] = temp;

      if (estaEnRadio(temp.geoloc.latitude, temp.geoloc.longitude, 5)) {
        Marker marcadorTemp = Marker(
          markerId: MarkerId(usuariosDescargados.docChanges[i].doc.id),
          position: LatLng(temp.geoloc.latitude, temp.geoloc.longitude),
          infoWindow: InfoWindow(
            title: temp.nombre,
            snippet: "Edad: ${temp.edad}",
          ),
        );
        marcTemp.add(marcadorTemp);
      }
    }

    // Verificar si el widget todavía está montado antes de llamar a setState
    if (mounted) {
      setState(() {
        marcadores.addAll(marcTemp);
      });
    }
  }

  void descargaUsuariosError(error) {
    print("Listen failed: $error");
  }

  bool estaEnRadio(double latitud, double longitud, double radio) {
    double distancia = Geolocator.distanceBetween(
      _ubicacionActual.latitude,
      _ubicacionActual.longitude,
      latitud,
      longitud,
    );

    double distanciaEnKilometros = distancia / 1000;

    return distanciaEnKilometros <= radio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAPA"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(104, 126, 255, 1),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kUser,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: marcadores,
      ),
    );
  }
}
