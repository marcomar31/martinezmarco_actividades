import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: Text('BIENVENIDO!!')),
            ]),
          ],),
      appBar: AppBar(
        title: const Text("HOME"),
        centerTitle: true,
        shadowColor: Colors.blue,
        backgroundColor: Colors.greenAccent.withOpacity(0.4),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.tealAccent,
    );
  }

}