import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tp_flutter_3/classes/dialogs.dart';
import '../model/materiel.dart';
import '../classes/dialogs.dart';
import '../CB.dart';
import '../repository/materielRepository.dart';
import '../controller/materiel_controller.dart';
import '../classes/menu.dart';



class MyMaterielDetailPage extends StatefulWidget {
  final String rep;
  const MyMaterielDetailPage({Key? key, required this.rep}) : super(key: key);

  @override

  State<MyMaterielDetailPage> createState() => _MyMaterielDetailPageState();

}

class _MyMaterielDetailPageState extends State<MyMaterielDetailPage> {

  final materielController = MaterielController(MaterielRepository());

  String repere = '';


  @override

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,


      appBar: AppBar(
        title: const Text('Matériel'),
        actions: [IconButton(
          onPressed: ()=>_navigateToCBScreen(context),

          icon: const Icon(
            Icons.search_rounded,
            color: Colors.white70,
            size: 35.0,

          ),
        )

        ],
      ),
      drawer: const MyDrawer(), // appel à la classe menu
      body:
        FutureBuilder(
                  future: materielController.materielFetch(widget.rep),
                  builder: (BuildContext context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                final data = snapshot.data;
                var materiel = jsonDecode(data.toString());

                return ListView(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 70.0),
                  children: <Widget>[

                  TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  textAlign: TextAlign.center,
                  initialValue: materiel[0]['rep'],
                  enabled: false,
                  readOnly: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Repère',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 5, color: Colors.blue),

                    ),
                  ),
                ),
                //const Divider(),

                    TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                  initialValue: materiel[0]['famille'],
                  enabled: false,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Famille',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 5, color: Colors.blue),
                    ),
                  ),
                ),
                //const Divider(),
                TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16),

                  textAlign: TextAlign.center,
                  initialValue: materiel[0]['modele'],
                  enabled: false,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Modèle',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.blue),
                      //borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                /*const Divider(
                thickness: 5,
                color: Colors.blueAccent,
                indent: 20,
                endIndent: 20,
              ),*/
                TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20),

                  textAlign: TextAlign.center,
                  initialValue: getFormatedDate(materiel[0]['prochaineDate']),
                  readOnly: true,
                  enabled: false,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Prochain contrôle avant le:',
                    /*enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),*/
                  ),
                ),
                //const Divider(),
                TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20),

                  textAlign: TextAlign.center,
                  initialValue: materiel[0]['periode'],
                  readOnly: true,
                  enabled: false,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Ce sera une périodicité',
                      /*enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.select_all),
                        onPressed: () =>
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  const DialogPeriodicite(), // dans classes.dart
                            ),
                      )*/
                  ),
                ),

                //const Divider(),
                TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16),

                  textAlign: TextAlign.center,
                  initialValue: getFormatedDate(materiel[0]['mes']),
                  enabled: false,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Mis en service le:',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.blue),
                      //borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                //const Divider(),
                TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16),

                  textAlign: TextAlign.center,
                  initialValue: materiel[0]['secteur'],
                  enabled: false,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Secteur',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.blue),
                      //borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                //const Divider(),
                TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16),

                  textAlign: TextAlign.center,
                  initialValue: materiel[0]['desi'],
                  enabled: false,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Désignation',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.blue),
                      //borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                //const Divider(),
                TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16),

                  textAlign: TextAlign.center,
                  initialValue: materiel[0]['ref'],
                  enabled: false,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Référence',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.blue),
                      //borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                //const Divider(),
                TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16),

                  textAlign: TextAlign.center,
                  initialValue: materiel[0]['comm'],
                  enabled: false,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Commentaire matériel',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.blue),
                      //borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                //const Divider(),
              ]
            );


        }

      ),



      /*bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        elevation: 10,
        child: ListTile(
          onTap: (){showDialog(
            barrierDismissible: false,// l'utilisateur doit presser un bouton pour sortir! (modale)
            context: context,
            builder: (context) => DialogAjoutControle( rep: widget.rep,),
          );},
          leading: const Text('Contrôler ce matériel'),
          title: const Icon(Icons.play_arrow_sharp),

        ),
      ),*/
        floatingActionButton: FloatingActionButton.extended(

          onPressed: ()
            {
              showDialog(
                barrierDismissible: false,// l'utilisateur doit presser un bouton pour sortir! (modale)
                context: context,
                builder: (context) => DialogAjoutControle( rep: widget.rep,),

              );
              /*showGeneralDialog(
                barrierDismissible: false,// l'utilisateur doit presser un bouton pour sortir! (modale)
                context: context,
                pageBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                       return DialogAjoutControle( rep: widget.rep,);
                },

              );*/
            },
          label: const Text('Contrôler ce matériel'),
          icon: const Icon(Icons.search_rounded),
          backgroundColor: Colors.blue,

        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyappCB(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      repere = result;

      //print(texte);
    });
  }
  getFormatedDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  void _navigateToCBScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
  }
}




/*// Mes requetes
Future<List<MaterielSModel>> getmySQLData(String rep) async {
  var db = Mysql();
  (rep == '')?rep='HBBA2':rep= rep;
  final List<MaterielSModel> mylist = [];
  await db.getConnection().then((conn) async {
    await conn.query('select '
        'materiel.id_materiel,'
        'materiel.rep_materiel,'
        'materiel.designation_materiel,'
        'materiel.reference_materiel,'
        'materiel.date_mes_materiel,'
        'materiel.commentaire_materiel,'
        'secteur.designation_secteur,'
        'secteur.commentaire_secteur,'
        'famille.designation_famille,'
        'modele.designation_modele,'
        'modele.type_modele,'
        'prochain_controle.intitule_perio as perio,'
        'MIN(prochain_controle.prochain_controle) as prochaineDate '
        'from materiel, secteur, modele, famille, prochain_controle '
        'where '
        'materiel.id_secteur = secteur.id_secteur '
        'and materiel.id_modele = modele.id_modele '
        'and materiel.id_famille = famille.id_famille '
        'and prochain_controle.rep_materiel = materiel.rep_materiel '
        'and materiel.rep_materiel = ?;',
        [rep]).then((results) {
      for (var res in results) {

        final MaterielSModel mymateriel = MaterielSModel(
            //materielId: res['id_materiel'].toString(),
            materielSRep: res['rep_materiel'].toString(),
            materielSDesi: res['designation_materiel'].toString(),
            materielSRef: res['reference_materiel'].toString(),
            materielSMes: res['date_mes_materiel'].toString(),
            materielSComm: res['commentaire_materiel'].toString(),
            materielSSect: res['designation_secteur'].toString(),
            materielSCommSect: res['commentaire_secteur'].toString(),
            materielSFam: res['designation_famille'].toString(),
            materielSMod: res['type_modele'].toString(),
            materielSProcDate: res['prochaineDate'].toString(),
            materielSPerio: res['perio'].toString(),

        );
        mylist.add(mymateriel);

        //(mylist.isNotEmpty)?mylist.add(mymateriel):Text('Rien à afficher');
      }
    }).onError((error, stackTrace) {
      print('erreur');
      //return ;
    });

    conn.close();
  });
  return mylist;
}



void _navigateToCBScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
}*/

/*Future<void> updateData(String id, String name, String email) async {
  final db = Mysql();
  final int userId = int.parse(id.toString());
// print(userId);
  await db.getConnection().then(
        (conn) async {
      await conn.query(
          'Update user set nom_user =? , login_user =? where id_user =?',
          [name, email, userId]);
      await conn.close();
    },
  );
}*/

/*Future<void> deleteData(String id) async {
  final db = Mysql();
  await db.getConnection().then((conn) async {
    await conn
        .query('Delete from user where id_user=?', [id]);
    conn.close();

  }).onError((error, stackTrace) {
    print(error);
    return null;
  });
}*/







/*class CBRoute extends StatelessWidget {
  const CBRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('scanner'),
      ),
      /*body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Retour'),
        ),
      ),*/
      body: Center(
          child: Text("Il faut remplir cette écran")
      ),


    )
  }*/


/*return ListView.builder(

itemCount: snapshot.data!.length,
itemBuilder: (context, index) {
//final materiel = snapshot.data![index];
final materiel = snapshot.data!.first;

return ListTile(
tileColor: Colors.blue[100],
leading: Text(materiel.materielSRep,
textAlign: TextAlign.center,
overflow: TextOverflow.ellipsis,

style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 25
),

), //Text(materiel.materielId),
title: Text(materiel.materielSDesi),
//subtitle: Text(materiel.materielDesi),
trailing: Row(
mainAxisSize: MainAxisSize.min,
children: const [],

)
);

},

);*/





