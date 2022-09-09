import '../repository/repositoryUser.dart';

class UserController {
  final RepositoryUser _repository;

  UserController(this._repository);

  Future<String> fetchUserControleurList() async {
    return _repository.getListControleur();
  }
}
