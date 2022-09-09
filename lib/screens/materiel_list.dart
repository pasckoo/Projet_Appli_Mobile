import 'package:flutter/material.dart';
import '../CB.dart';
import '../classes/menu.dart';
import 'materiel_detail.dart';
import '../repository/materielRepository.dart';
import '../controller/materiel_controller.dart';
import '../model/materiel.dart';



class MyMaterielListPage extends StatefulWidget {
  const MyMaterielListPage({Key? key, required this.title}) : super(key: key);
  final String title;
  get materiel => null;
  @override
  State<MyMaterielListPage> createState() => _MyMaterielListPageState();

}




class _MyMaterielListPageState extends State<MyMaterielListPage> {
  int _selectedIndex = 0;
  var materielController=MaterielController(MaterielRepository());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        //toolbarHeight: 150,
        title: const Text('Liste du matériel'),
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
      body: Center(


        child: FutureBuilder<List<MaterielList>>(

          future: materielController.fetchMaterielList(),
          builder: (BuildContext context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text(
                  'Pas de connexion'); //Text(snapshot.error.toString());
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
              final materiel = snapshot.data![index];

                return Card(
                  margin: const EdgeInsets.only(left:20.0,top:4.0,right:20.0,bottom:4.0),
                  shadowColor: Colors.blue[800],
                  elevation: 14,
                  semanticContainer: true,

                  child: ListTile(
                      //selected: index == _selectedIndex,

                      onTap: () {
                        setState(() {
                          var repe = materiel.repMateriel.toString();
                          Navigator.push(
                              context,
                          MaterialPageRoute(
                            builder: (context) => MyMaterielDetailPage(rep: repe),
                          ));

                    });
                  },
                  //tileColor: Colors.yellow[200],
                      leading: const Icon(Icons.qr_code_2_rounded),//Text(user.userLogin,
                      //textAlign: TextAlign.center,
                  //overflow: TextOverflow.ellipsis,

                  //style: const TextStyle(
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 18
                  //  ),

                  //  ),
                  //Text(materiel.materielId),
                  title: Text((materiel.repMateriel).toString()),
                  subtitle: Text((materiel.designationMateriel).toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [],


                  ),
                  ),
                );
              },

            );
          },

        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        elevation: 10,

        child: ListTile(
          onTap: ()=>_navigateToCBScreen(context),


        ),
      ),

      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Colors.orangeAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            label: 'Matériel',
            icon: Icon(Icons.qr_code),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),*/

      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          //setState(() {});
          _awaitReturnValueFromSecondScreen(context);
          /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyappCB()),
          );*/

          //setState(() {});
        },
        child: const Icon(Icons.scanner_rounded),


      ),*/
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,


    );


  }
  void _navigateToCBScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyappCB()));
  }


  /*void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyMaterielPage(rep:''),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      //repere = result;

      //print(texte);
    });
  }*/



/*// Mes requetes
  Future<List<MaterielModel>> getmySQLMaterielData() async {
    var db = Mysql();

    final List<MaterielModel> mylist = [];
    await db.getConnection().then((conn) async {
      await conn.query('select id_materiel, rep_materiel, designation_materiel from materiel'
      ).then((results) {
        for (var res in results) {
          final MaterielModel mymateriel1 = MaterielModel(
            materielRep: res['rep_materiel'].toString(),
            materielDesi: res['designation_materiel'].toString(),
          );
          mylist.add(mymateriel1);

          //(mylist.isNotEmpty)?mylist.add(mymateriel):Text('Rien à afficher');
        }
      }).onError((error, stackTrace) {
        print(mylist.toString());
        return null;
      });

      conn.close();
    });
    return mylist;
  }


Future<void> updateData(String id, String name, String email) async {
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

}






