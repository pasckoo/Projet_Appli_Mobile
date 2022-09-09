import '../model/materiel.dart';
import '../model/perio.dart';

abstract class RepositoryMateriel{
  Future<List<MaterielList>> getMaterielList();
  Future<String> materielDetail(String materielDetail);
  Future<List<MaterielList>> getMaterielRetard();
  Future<List<MaterielList>> getMateriel30jours();
//Future<String> deleteTodo(Todo todo);
//Future<String> postTodo(Todo todo);

}

