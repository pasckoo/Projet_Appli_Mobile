class ControleAjout {

  String? date;
  String? idMateriel;
  String? idPerio;
  String? idUser;
  String? commControle;
  String? dateSuivant;

  ControleAjout({
    this.date,
    this.idMateriel,
    this.idPerio,
    this.idUser,
    this.commControle,
    this.dateSuivant,
  });

  ControleAjout.fromJson(Map<String, dynamic> json) {
    date = json["date_controle"].toString();
    idMateriel = json["id_materiel"];
    idPerio = json["id_perio"];
    idUser = json["id_user"];
    commControle = json["comment_controle"];
    dateSuivant = json["date_suiv_controle"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_controle'] = date.toString();
    data['id_materiel'] = idMateriel.toString();
    data['id_perio'] = idPerio.toString();
    data['id_user'] = idUser.toString();
    data['comment_Controle'] = commControle.toString();
    data['date_suiv_controle'] = dateSuivant.toString();

    return data;
  }
}

class ControleList {

  String? date;
  String? repMateriel;
  String? intitulePerio;


  ControleList({
    this.date,
    this.repMateriel,
    this.intitulePerio,
  });

  ControleList.fromJson(Map<String, dynamic> json) {
    date = json["prochain_controle"].toString();
    repMateriel = json["rep_materiel"];
    intitulePerio = json["intitule_perio"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prochain_controle'] = date.toString();
    data['id_materiel'] = repMateriel.toString();
    data['id_perio'] = intitulePerio.toString();

    return data;
  }
}