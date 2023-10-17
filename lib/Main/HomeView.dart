import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Custom/PostCellView.dart';
import '../Custom/PostGridCellView.dart';
import '../FirestoreObjects/FbPost.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];

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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
      Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16), child:
        Center(child:
          /*ListView.separated(
            padding: EdgeInsets.all(80),
            itemCount: posts.length,
            itemBuilder: creadorDeItemLista,
            separatorBuilder: creadorDeSeparadorLista,
          ),*/
        PostGridCellView(posts: posts),
        ),
      ),
      appBar: AppBar(
        title: const Text("HOME"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(104, 126, 255, 1),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color.fromRGBO(128, 179, 255, 1),
    );
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
}
