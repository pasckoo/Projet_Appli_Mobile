class UserControleur {
  String? userFirstName ;
  String? userName ;
  String? userLogin ;
  String? userControleur ;


  UserControleur({this.userLogin});

  UserControleur.fromJson(Map<String, dynamic> json) {
    userLogin = json["user_login"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_login'] = userLogin.toString();
    return data;
  }

}

