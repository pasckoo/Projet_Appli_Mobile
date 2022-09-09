import 'package:flutter/material.dart';
import '../repository/perioRepository.dart';
import '../repository/userRepository.dart';
import '../controller/perio_controller.dart';
import '../controller/user_controller.dart';
import '../model/perio.dart';
import 'dart:convert';

class DeroulantePerio extends StatefulWidget {
  final String rep;
   DeroulantePerio({Key? key, required this.rep}) : super(key: key);


  @override
  String retour = '';
  State<DeroulantePerio> createState() => _DeroulantePerioState();
}

class _DeroulantePerioState extends State<DeroulantePerio> {
  var deroulanteController = PerioController(PerioRepository());

  @override
  Widget build(BuildContext context) {

    Future: return FutureBuilder<String>(

      future: deroulanteController.fetchPerioControleList(widget.rep),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text(
              'Pas de connexion'); //Text(snapshot.error.toString());
        }

        final List<String> liste = [];
        String? selectedListe;
        final data = snapshot.data!;
        var perio = jsonDecode(data);

        for(var i = 0; i < perio.length; i++ ) {
          liste.add(perio[i]['intitule_perio']);
        }

        return DropdownButtonFormField<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer une valeur';
            }
            return null;
          },
          /*decoration: const InputDecoration(
            prefixIcon: Icon(Icons.timer_sharp),
          ),*/
          hint: const Text("Périodicité"),
          value: selectedListe,
          items: liste.map((item) =>
            DropdownMenuItem<String>(
              value: item,
              child: Text(item.toString()),
            )
          ).toList(),
          onChanged: (String? value) {
              selectedListe = value;
              widget.retour = selectedListe!;
          },
        );
      }
    );
  }
}

class DeroulanteControleur extends StatefulWidget {
  DeroulanteControleur({Key? key}) : super(key: key);
  @override
  String retour = '';

  State<DeroulanteControleur> createState() => _DeroulanteControleurState();
}

class _DeroulanteControleurState extends State<DeroulanteControleur> {
  var userController=UserController(UserRepository());
  @override
  Widget build(BuildContext context) {
    Future: return FutureBuilder<String>(

        future: userController.fetchUserControleurList(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text(
                'Pas de connexion'); //Text(snapshot.error.toString());
          }

          final List<String> liste = [];
          String? selectedListe;
          final data = snapshot.data!;
          var controleur = jsonDecode(data);

          for(var i = 0; i < controleur.length; i++ ) {
            liste.add(controleur[i]['login_user']);
          }

          return DropdownButtonFormField<String>(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer une valeur';
              }
              return null;
            },
            /*decoration: const InputDecoration(
            prefixIcon: Icon(Icons.timer_sharp),
          ),*/
            hint: const Text("Contrôleur"),
            value: selectedListe,
            items: liste.map((item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Text(item.toString()),
                )
            ).toList(),
            onChanged: (String? value) {
              selectedListe = value;
              widget.retour = selectedListe!;
            },
          );
        }
    );
  }
}