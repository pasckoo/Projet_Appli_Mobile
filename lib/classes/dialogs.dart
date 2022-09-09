
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp_flutter_3/classes/listDeroulante.dart';
import '../controller/perio_controller.dart';
import '../repository/controleRepository.dart';
import '../controller/controle_controller.dart';
import '../model/perio.dart';
import '../repository/perioRepository.dart';


class DialogControles extends StatelessWidget {
  const DialogControles({Key? key}) : super(key: key);

  @override

  build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: const Text('INFORMATION',
        textAlign: TextAlign.center,),

      content: const Text(
        'Il n\'y a aucun contrôle à afficher',
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),

      ],
    );
  }
}


class DialogQuitter extends StatelessWidget {
  const DialogQuitter({Key? key}) : super(key: key);

  @override

   build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),

      title: const Text('QUITTER',
        textAlign: TextAlign.center,),
      content: const Text(
        'Vous allez quitter l\'application',
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onPressed: () => exit(0),
          child: const Text('Quitter'),
        ),
      ],
    );
  }
}


class DialogConnexion extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  var materielController=PerioController(PerioRepository());
  DialogConnexion({Key? key}) : super(key: key);
  @override
  build(BuildContext context) {
    return AlertDialog(
      title: const Text('CONNEXION'),
      content: Wrap(
        children: <Widget>[
          TextFormField(
            controller: _controller,

            onChanged: (value) => value,
            decoration: const InputDecoration(
              icon: Icon(Icons.private_connectivity),
              labelText: 'Host',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pop(context, _controller.text),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class DialogAjoutControle extends StatelessWidget {
  DialogAjoutControle({Key? key, required this.rep}) : super(key: key);
  final String rep;
  final _formKey = GlobalKey<FormState>();

  @override

  build(BuildContext context) {
    final  myController = TextEditingController();
    final controleController = ControleController(ControleRepository());
    var myPerio = DeroulantePerio(rep: rep);
    var myControleur = DeroulanteControleur();
    String dateControle = getFormatedDate(DateTime.now().toString());
    String commentaire = '';
        return AlertDialog(

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),

            title: Wrap(children: <Widget>[

              Row(children: const [
                Icon(
                  Icons.fact_check,
                  color: Colors.blueAccent,
                  size: 35,),
                    Text(
                      '  Ajouter un contrôle',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),

                ],
              ),
            ]),
            content: SingleChildScrollView(

              child: ListBody(

              children: <Widget>[

                  Form(
                  key: _formKey,
                    child: Column(
                      children: <Widget>[
                          TextFormField(
                            controller: TextEditingController(text: dateControle),

                            onChanged: (value) => value,
                            decoration: const InputDecoration(
                              //icon: Icon(Icons.private_connectivity),
                            labelText: 'Date du contrôle',
                          ),
                        ),
                          TextFormField(
                            controller: TextEditingController(text: rep),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer une valeur';
                              }
                              return null;
                            },
                            onChanged: (value) => value,
                            decoration: const InputDecoration(
                              //icon: Icon(Icons.private_connectivity),
                              labelText: 'Repère',
                            ),
                          ),
                        myPerio,
                        myControleur,

                        TextFormField(
                         // controller: commentaire,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          onChanged: (value) => commentaire = value,
                          decoration: const InputDecoration(
                            //icon: Icon(Icons.private_connectivity),
                            labelText: 'Commentaire',
                    ),
          ),
          ]
         ),
        )
        ],

      )),
            actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () { // Validate renvoie true si le formulaire est valide,
                // ou false sinon.
                  if ( _formKey.currentState!.validate ()) {

                    controleController.createPatchCompleted(
                      DateTime.now().toString(),
                      rep,
                      myPerio.retour,
                      myControleur.retour,
                      commentaire

                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of( context ).
                    showSnackBar ( const SnackBar (

                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 3),
                        content : SizedBox(
                          height: 50,
                          child: Center(child:
                          Text('Envoi en cours...',
                          style: TextStyle(fontSize: 25,
                              fontWeight: FontWeight.bold),),

                          ),),)
                    ); } },
              child: const Text('Valider'),
        ),

      ]
    );

  }

  getFormatedDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }
}
