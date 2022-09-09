import 'dart:io';
import 'dialogs.dart';
import 'package:flutter/material.dart';
import 'package:tp_flutter_3/main.dart';

import '../screens/materiel_detail.dart';
import '../screens/materiel_list.dart';
import '../CB.dart';


class MyDrawer extends StatelessWidget {
  @override
  static const couleurDivider = Colors.blueAccent;

  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(

        padding: EdgeInsets.zero,
        children: <Widget>[

          const DrawerHeader(

            decoration: BoxDecoration(
              color: couleurDivider,
              image: DecorationImage(
                  image: AssetImage("assets/images/cover.jpg"),
                  fit: BoxFit.cover),

            ),

            child: Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),

          ),
          ListTile(


            enabled: true,
            leading: const Icon(Icons.home, color: Colors.deepOrangeAccent),
            title: const Text(
              'Tableau de bord',
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepOrangeAccent,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              //_navigateToNextScreen(context);
              _navigateToAccueilScreen(context);
            },
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),

          ),
          const Divider(
            color: couleurDivider,
          ),
          ListTile(
            enabled: true,
            leading: const Icon(Icons.qr_code, color: Colors.deepOrangeAccent),
            title: const Text(
              'Matériels',
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepOrangeAccent
              ),
            ),
            subtitle: const Text('Liste complète du matériel',),
            onTap: () {
              Navigator.pop(context);
              //_navigateToNextScreen(context);
              _navigateToMaterielScreen(context);
            },
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),

          ),
          const Divider(
            color: couleurDivider,
          ),
          ListTile(
            leading: const Icon(Icons.checklist_rounded, color: Colors.deepOrangeAccent),
            title: const Text(
              'Contrôles',
              style: TextStyle(
                fontSize: 20,
                  color: Colors.deepOrangeAccent
              ),
            ),
            subtitle: const Text('',),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            color: couleurDivider,
          ),
          ListTile(
            leading: const Icon(Icons.people, color: Colors.deepOrangeAccent),
            title: const Text(
              'Planning',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrangeAccent
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            color: couleurDivider,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded, color: Colors.deepOrangeAccent),
            onTap: (){
              Navigator.pop(context);
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => const DialogQuitter(), // dans classes.dart
              );

            },
            title: const Text(
              'Quitter',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrangeAccent
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
        ],
      ),
    );


  }
}

void _navigateToMaterielScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyMaterielListPage(title: '',)));
}

void _navigateToAccueilScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
}

void _navigateToCBScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
}

void _navigateToNextScreen2(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyMaterielDetailPage(rep:'' )));
}
