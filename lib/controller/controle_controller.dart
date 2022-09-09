import 'package:tp_flutter_3/classes/listDeroulante.dart';

import '../model/controle.dart';
import '../repository/repositoryControle.dart';

class ControleController {
  final RepositoryControle _repository;

  ControleController(this._repository);

  createPatchCompleted(
      String dateCon,
      String rep,
      String perio,
      String controleur,
      String comm) {
        return _repository.controleAjout(
          dateCon,
          rep,
          perio,
          controleur,
          comm);
        }

  Future<List<ControleList>> fetchControleRetard() {
    return _repository.getControleRetard();
  }

  Future<List<ControleList>> fetchControle30jours() {
    return _repository.getControle30jours();
  }

}