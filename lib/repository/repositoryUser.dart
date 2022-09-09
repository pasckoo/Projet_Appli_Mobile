import '../model/user.dart';

abstract class RepositoryUser{
  Future<String> getListControleur();

}