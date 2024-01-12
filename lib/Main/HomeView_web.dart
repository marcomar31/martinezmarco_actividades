
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../Custom/BottomMenu.dart';
import '../Custom/PostCellView.dart';
import '../Custom/PostGridCellView.dart';
import '../FirestoreObjects/FbPost.dart';
import '../Singletone/DataHolder.dart';
import '../Singletone/FireBaseAdmin.dart';
import '../Singletone/HttpAdmin.dart';
import 'SearchPostsView.dart';

class HomeView_web extends StatefulWidget {
  const HomeView_web({super.key});

  @override
  _HomeView_webState createState() => _HomeView_webState();
}

class _HomeView_webState extends State<HomeView_web> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  HttpAdmin httpAdmin = DataHolder().httpAdmin;
  FBAdmin fbAdmin = DataHolder().fbAdmin;

  final List<FbPost> posts = [];
  bool blIsList = false;
  late BottomMenu bottomMenu;
  late Position position;

  late double temperatura;

  final TextEditingController _searchController = TextEditingController();
  List<FbPost> searchResults = [];

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostCellView(sText: posts[index].titulo,
        dFontSize: 20);
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return const Divider(color: Color.fromRGBO(37, 77, 152, 1.0), thickness: 2,);
  }

  Widget celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: const EdgeInsets.all(80),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    } else {
      return PostGridCellView(posts: posts);
    }
  }

  void descargarPosts() async {
    CollectionReference<FbPost> reference = db
        .collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost usuario, _) => usuario.toFirestore());

    QuerySnapshot<FbPost> querySnap = await reference.get();
    for (int i = 0; i < querySnap.docs.length; i++) {
      setState(() {
        posts.add(querySnap.docs[i].data());
      });
    }
  }

  void onBottonMenuPressed(int indice) {
    setState(() {
      if(indice == 0){
        blIsList = true;
      }
      else if(indice == 1){
        blIsList = false;
      }
      else if(indice == 2){
        Navigator.of(context).popAndPushNamed('/loginview');
      }
    });

  }

  Future<void> determinarPosicionActual() async {
    position = await DataHolder().geolocAdmin.determinePosition();
  }

  Future<void> determinarTemperaturaActual() async {
    await determinarPosicionActual();
    temperatura = await httpAdmin.pedirTemperaturasEn(position.latitude, position.longitude);
  }

  Future<void> mostrarCuadroDialogoTemperatura() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("TEMPERATURA ACTUAL"),
          content: Container(
            height: 80.0, // Ajusta la altura según tus necesidades
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Cargando..."),
                const SizedBox(height: 10.0),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );

    try {
      await determinarTemperaturaActual();
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("TEMPERATURA ACTUAL"),
            content: Text("La temperatura en su ubicacion actual es de $temperatura ºC"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Volver"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print("Error al obtener la temperatura: $error");
      Navigator.of(context).pop();
    }
  }

  Future<bool> buscarPosts() async {
    String searchText = _searchController.text;
    List<FbPost> results = await fbAdmin.buscarPostsPorTitulo(searchText);
    if (searchText.isNotEmpty) {
      if (results.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No se encontraron resultados'), duration: Duration(seconds: 2),),);
        return false;
      } else {
        setState(() {
          searchResults = results;
        });
        return true;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('El texto de búsqueda no puede estar en blanco'), duration: Duration(seconds: 2),),);
      return false;
    }
  }

  void mostrarCuadroDialogoBusqueda() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Buscar Posts"),
          content: TextField(
            controller: _searchController,
            decoration: const InputDecoration(hintText: "Ingrese el texto de búsqueda"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                if (await buscarPosts()) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchPostsView(searchResults: searchResults),
                    ),
                  );

                }
              },
              child: const Text("Buscar"),
            ),
          ],
        );
      },
    );
  }

  Future<void> mostrarCuadroDialogoChiste() async {
    String textoChiste = ""; // Inicializamos con un valor por defecto

    await httpAdmin.obtenerChisteRandom().then((chiste) {
      textoChiste = chiste;
    }).catchError((error) {
      print("Error al obtener el chiste: $error");
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("CHISTE ALEATORIO EN INGLÉS!!!"),
          content: Text(textoChiste),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Volver"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    descargarPosts();
    super.initState();
    inicializarDatos();
  }

  Future<void> inicializarDatos() async {
    await determinarPosicionActual();
    await determinarTemperaturaActual();
    DataHolder().suscribeACambiosGPSUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Center(
          child: celdasOLista(blIsList),
        ),
      ),
      appBar: AppBar(
        title: const Text("HOME"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(104, 126, 255, 1),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              mostrarCuadroDialogoChiste();
            },
            child: const Row(
              children: [
                Icon(Icons.sentiment_very_satisfied),
                SizedBox(width: 8),
                Text('Chiste random'),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              mostrarCuadroDialogoBusqueda();
            },
          ),
          IconButton(
            icon: const Icon(Icons.thermostat),
            onPressed: () {
              mostrarCuadroDialogoTemperatura();
            },
          ),
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.of(context).pushNamed("/mapaview");
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navegar a la vista de configuración aquí
              Navigator.of(context).pushNamed('/gestionadministracionview');
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(onBotonesClicked: onBottonMenuPressed),
      backgroundColor: const Color.fromRGBO(128, 179, 255, 1),
    );
  }
}
