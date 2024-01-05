import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:martinezmarco_actividades1/Singletone/DataHolder.dart';
import 'package:martinezmarco_actividades1/Singletone/FireBaseAdmin.dart';

import '../Custom/BottomMenu.dart';
import '../Custom/Drawer_mobile.dart';
import '../Custom/PostCellView.dart';
import '../Custom/PostGridCellView.dart';
import '../FirestoreObjects/FbPost.dart';

class SearchPostsView extends StatefulWidget {
  final List<FbPost> searchResults;

  SearchPostsView({required this.searchResults});

  @override
  _SearchPostsViewState createState() => _SearchPostsViewState();
}

class _SearchPostsViewState extends State<SearchPostsView> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  FBAdmin fbAdmin = DataHolder().fbAdmin;
  final List<FbPost> posts = [];
  bool blIsList = false;
  late BottomMenu bottomMenu;

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostCellView(sText: posts[index].titulo,
        dFontSize: 20);
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return Divider(color: Color.fromRGBO(37, 77, 152, 1.0), thickness: 2,);
  }

  @override
  void initState() {
    descargarPosts();
    super.initState();
    print(widget.searchResults.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados de búsqueda"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(104, 126, 255, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Center(
          child: celdasOLista(blIsList),
        ),
      ),
      bottomNavigationBar: BottomMenu(onBotonesClicked: onBottonMenuPressed),
      backgroundColor: const Color.fromRGBO(128, 179, 255, 1),
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

  void descargarPosts() async {
    try {
      posts.clear();
      if (widget.searchResults.isNotEmpty) {
        posts.addAll(widget.searchResults);
      }
    } catch (e) {
      print("Error al descargar posts: $e");
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
}