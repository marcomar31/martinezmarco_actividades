import 'package:flutter/material.dart';

class Drawer_mobile extends StatelessWidget{

  Function(int indice)? onItemTap;

  Drawer_mobile({super.key,required this.onItemTap
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
                style: TextStyle(color: Colors.white),
                'MENÚ'
            ),
          ),
          ListTile(
            leading: const Icon(Icons.map),
            selectedColor: Colors.blue,
            selected: true,
            title: const Text('Mapa'),
            onTap: () {
              onItemTap!(0);
            },
          ),
          ListTile(
            title: const Text("Botón 2"),
            onTap: () {
              onItemTap!(1);
            },
          ),
        ],
      ),
    );
  }

}