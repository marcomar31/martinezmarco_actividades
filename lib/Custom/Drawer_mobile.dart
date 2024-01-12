import 'package:flutter/material.dart';

class Drawer_mobile extends StatelessWidget{

  final Function(int indice)? onItemTap;

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
            title: const Text('Mapa'),
            onTap: () {
              onItemTap!(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.thermostat),
            title: const Text("Consultar temperatura"),
            onTap: () {
              onItemTap!(1);
            },
          ),
        ],
      ),
    );
  }

}