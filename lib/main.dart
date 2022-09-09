
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tp_flutter_3/classes/dialogs.dart';
import 'package:tp_flutter_3/repository/perioRepository.dart';
import 'classes/graphique.dart';
import 'classes/dialogs.dart';
import 'classes/menu.dart';
import 'CB.dart';
import 'controller/perio_controller.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../screens/controle_retard.dart';
import '../screens/controle_30jours.dart';

void main() {
  //var inputHost = '192.168.5.57';
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home:  AnimatedSplashScreen(
          duration: 2000,
          splash: 'assets/images/oiseau.gif',
          splashIconSize: 200.0,
          nextScreen: const Home(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.bottomToTop,
          backgroundColor: Colors.white));

  }
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

}
   class _HomeState extends State<Home> {
     var retardController= PerioController(PerioRepository());
     var joursController= PerioController(PerioRepository());




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,


        appBar: AppBar(
            title: const Text('Tableau de bord'),
            actions: [IconButton(

              onPressed: () => showDialog(
                context: context,
                builder: (context) => DialogConnexion(),
              ).then((val) {
                  setState(() {
                    //inputHost = val!;
                  });
                }),


              icon: const Icon(
                Icons.adb_sharp,
                color: Colors.white70,
                size: 35.0,

              ),
            )

            ],
        ),
        drawer: const MyDrawer(),
        body: Wrap(

          children:<Widget>[

              FutureBuilder(
                  future: retardController.fetchRetardControleList(),

                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    final data = snapshot.data;
                    final resultat = json.decode(data.toString());

                    int tard = resultat[0]['nbRetard'];
                    int prochain = resultat[1]['nbProchain'];
                    int reste = resultat[2]['nbReste'];
                    int total = tard + prochain + reste;
                    String strTotal = total.toString();

                    //int chiffre = 5;
                    return  PieChartSample2(retard: tard, prochain: prochain, reste: reste);

                  }),
            const Divider(
                height:4,
                thickness: 5,
                indent: 0,
                endIndent: 0,
                color: Colors.white,
              ),
            Card(
              color: Colors.white,
              shadowColor: Colors.blueGrey,
              elevation: 18,
              margin: const EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),),

              child: FutureBuilder(
                future: retardController.fetchRetardControleList(),

                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  final data = snapshot.data;
                  final resultat = json.decode(data.toString());

                  int tard = resultat[0]['nbRetard'];
                  int prochain = resultat[1]['nbProchain'];
                  int reste = resultat[2]['nbReste'];
                  int total = tard + prochain + reste;
                  String strTotal = total.toString();

                  return affichageControle(total, tard, prochain, context);

              }
            )
          )
        ]
      ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.orange,
                elevation: 10,

                child: ListTile(
                  leading: const Icon(
                    Icons.search_rounded,
                    color: Colors.white70,
                    size: 35.0,

                  ),
                  title: const Text('Chercher un matériel',
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                  onTap: ()=>_navigateToCBScreen(context),


                ),
      ),

              );

  }

  }


  void _navigateToCBScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
}

void _navigateToRetardScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyControleRetardPage()));
}

void _navigateTo30joursScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyControle30joursPage()));
}


// affichages sous le graphique pie
 affichageControle(int total, int tard, int prochain, BuildContext context){

    return Wrap(
      children: [
      ListTile(
          onTap: () {
            if(tard != 0) {
              _navigateToRetardScreen(context);
            }else{
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => const DialogControles(), // dans classes.dart
              );
            }
          },
          leading: const Text('Contrôles en retard: ',
            style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.redAccent,
            ),
          ),
          title: Text((tard).toString(),
            style: const TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.redAccent,
            ),
          ),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded),
        ),

        ListTile(
          onTap: () {
            if(prochain != 0) {
              _navigateTo30joursScreen(context);
            }else{
              showDialog<String>(
                context: context,
                builder: (BuildContext context){
                  return const DialogControles();
                  },
              );
            }
          },
          leading: const Text('Contrôles à 30 jours: ',
            style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.orange,
            ),
          ),
          title: Text((prochain).toString(),
            style: const TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.orange,
            ),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right_rounded),
        ),

      ListTile(
        onTap: () {
          if(total != 0) {
            _navigateTo30joursScreen(context);
          }else{
            showDialog<String>(
              context: context,
              builder: (BuildContext context){
                return const DialogControles();
              },
            );
          }
        },

        leading: const Text('Contrôles programmés: ',
          style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black54,
          ),
        ),
        title: Text(total.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black54,
          ),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded),
        ),
      ]
    );

}











