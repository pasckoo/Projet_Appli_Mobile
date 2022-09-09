import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:tp_flutter_3/repository/repositoryUser.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;

class UserRepository implements RepositoryUser {
  String dataURL = 'http://151.80.129.92/mob/user';
  //String dataURL = 'http://192.168.5.57/projet_PORTIQUE/mob/user';
  @override

  Future<String> getListControleur() async {
    Map data = {'controleur': 'login'};
    var url = Uri.parse('$dataURL/user_list.php');
    http.Response response = await http.post(
      url,
      //headers: {'Content-type': 'application/json'},
      // 'Accept': 'application/json'};//.then((value) => null);
      body: data,);
    //var response = await http.get(url);
    print('status code : ${response.statusCode}');
    //var body = json.decode(response.body);
    //print((response.body).toString());
    //for (var i = 0; i < body.length; i++) {
    //perioList.add(PerioListControle.fromJson(body[i]));
    //}
    print(response.body);
    return response.body;
  }
}