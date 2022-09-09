import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'screens/materiel_detail.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //var resultat = '';
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List todoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Contrôles réglementaires'),
      ),

        body: Container(
          decoration: const BoxDecoration( image: DecorationImage(
            image: AssetImage("assets/images/cover.jpg"),
            fit: BoxFit.cover, ), ),

          /* add child content here */
        ),


        //Image.asset('assets/images/cover.jpg'),

    floatingActionButton: FloatingActionButton(
    onPressed: () {
    //setState(() {});
    _navigateToNextScreen(context);
    setState(() {});
    },
      child: const Icon(Icons.arrow_upward_rounded),
          )
    );



          /*child: Text(
            (todoList.isNotEmpty ? todoList[0] +  '\n ' + todoList[1] : ''),

            style: Theme.of(context).textTheme.headline5,
          ),*/




  }
  /*connexion() async {
    print("Connecting to mysql server...");
    var retour = '';
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "192.168.43.137",
      port: 3306,
      userName: "pasckoo",
      password: "Bonjour01@",
      databaseName: "gdcr", // optional
      secure: false,
    );

    await conn.connect();
    //print("Je suis connecté");
    //resultat = "Je suis connecté";

    var result = await conn.execute("SELECT rep_materiel, designation_materiel  FROM materiel WHERE rep_materiel = :id", {"id": "H1EXE1" });

    for (final row in result.rows) {
      print(row.assoc().length);
      todoList.add(row.colAt(0));
      todoList.add(row.colAt(1));
      print(row.colAt(1));

    }
    setState(() {});

  }*/

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyMaterielPage(title:'' )));
  }
}








