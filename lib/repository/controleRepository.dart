import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:tp_flutter_3/repository/repositoryControle.dart';
import 'package:http/http.dart' as http;

import '../model/controle.dart';

class ControleRepository implements RepositoryControle {
  String dataURL = 'http://151.80.129.92/mob/controle';

  @override
   Future controleAjout(
      String dateCon,
      String rep,
      String perio,
      String controleur,
      String comm) async {

    Map data = {
      'dateCon': dateCon,
      'rep_mat': rep,
      'perio_con': perio,
      'controleur_con': controleur,
      'comm_con': comm
    };

    var url = Uri.parse('$dataURL/controle.php');
    final http.Response response = await http.post(
      url,
      //headers: {'Content-type': 'application/json'
      //'Accept': 'application/json'}.then((value) => null);
      body: data);
    //print(response.statusCode);
    print((response.body).toString());
    //return response.body;
    //print(data);
  }

  @override
  Future<List<ControleList>> getControleRetard() async {
    List<ControleList> controleRetard = [];
    Map data = {'retard_perio': '2330'};
    var url = Uri.parse('$dataURL/controle_perio.php');
    http.Response response = await http.post(
      url,
      //headers: {'Content-type': 'application/json'},
      // 'Accept': 'application/json'};//.then((value) => null);
      body: data,);
    //var response = await http.get(url);
    //print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    //print((response.body).toString());
    for (var i = 0; i < body.length; i++) {
      controleRetard.add(ControleList.fromJson(body[i]));

    }
    print(body);
    return controleRetard;
  }

  @override
  Future<List<ControleList>> getControle30jours() async {
    List<ControleList> controle30jours = [];
    Map data = {'30jours_perio': '1962'};
    var url = Uri.parse('$dataURL/controle_perio.php');
    http.Response response = await http.post(
      url,
      //headers: {'Content-type': 'application/json'},
      // 'Accept': 'application/json'};//.then((value) => null);
      body: data,);
    //var response = await http.get(url);
    //print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    //print((response.body).toString());
    for (var i = 0; i < body.length; i++) {
      controle30jours.add(ControleList.fromJson(body[i]));

    }
    print(body);
    return controle30jours;
  }

}