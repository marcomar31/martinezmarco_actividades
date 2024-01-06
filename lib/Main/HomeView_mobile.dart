import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:martinezmarco_actividades1/Singletone/DataHolder.dart';
import 'package:martinezmarco_actividades1/Singletone/FireBaseAdmin.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Custom/BottomMenu.dart';
import '../Custom/Drawer_mobile.dart';
import '../Custom/PostCellView.dart';
import '../Custom/PostGridCellView.dart';
import '../FirestoreObjects/FbPost.dart';
import 'SearchPostsView.dart';

class HomeView_mobile extends StatefulWidget {
  @override
  _HomeView_mobileState createState() => _HomeView_mobileState();
}

class _HomeView_mobileState extends State<HomeView_mobile> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  FBAdmin fbAdmin = DataHolder().fbAdmin;
  final List<FbPost> posts = [];
  bool blIsList = false;
  late BottomMenu bottomMenu;
  final TextEditingController _searchController = TextEditingController();
  List<FbPost> searchResults = [];

  late Position position;

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostCellView(sText: posts[index].titulo,
        dFontSize: 20);
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return Divider(color: Color.fromRGBO(37, 77, 152, 1.0), thickness: 2,);
  }

  void fHomeViewDrawerOnTap(int indice){
    if (indice == 0) {
      //Botón 1 del menú vertical
    } else if(indice==1){
      //Botón 2 del menú vertical
    }
  }

  @override
  void initState() {
    descargarPosts();
    super.initState();
    determinarPosicionInicial();
    DataHolder().suscribeACambiosGPSUsuario();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(104, 126, 255, 1),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              mostrarCuadroDialogoBusqueda();
            },
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Center(
            child: celdasOLista(blIsList),
          ),
      ),
      drawer: Drawer_mobile(onItemTap: fHomeViewDrawerOnTap),
      bottomNavigationBar: BottomMenu(onBotonesClicked: this.onBottonMenuPressed),
      backgroundColor: Color.fromRGBO(128, 179, 255, 1),
    );
  }

  Widget celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(80),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    } else {
      return PostGridCellView(posts: posts);
    }
  }

  Future<void> determinarPosicionInicial() async {
    position = await DataHolder().geolocAdmin.determinePosition();
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

  Future<bool> buscarPosts() async {
    String searchText = _searchController.text;
    print(searchText);
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
    // TODO: implement onBottonMenuPressed
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
}