import 'package:mysql1/mysql1.dart';
import 'dart:async';
import '../main.dart' as main;
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../model/user.dart';



class Mysql {

  String myHost = '192.168.5.57'; // variable venant de main.dart (connexion)

  static String user = 'pasckoo',
      password = 'Bonjo',
      db = 'gdcr';
  static int port = 3306;

  Mysql();



  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: myHost,
        port: port,
        user: user,
        password: password,
        db: db,
        timeout: const Duration(seconds: 10),


    );
    return await MySqlConnection.connect(settings);
  }
}

