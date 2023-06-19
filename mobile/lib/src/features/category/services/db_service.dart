import 'package:cloud_firestore/cloud_firestore.dart';
import '../store/category_model.dart';

class DbService {
  DbService();

  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> listar() {
    return _db.collection("categories").get().then((querySnapshot) {
      final categories = <CategoryModel>[];

      for (var doc in querySnapshot.docs) {
        final dados = doc.data();
        final tarefa =
            CategoryModel(nome: dados['nome'], prioridade: dados['prioridade']);
        tarefa.key = doc.id;
        categories.add(tarefa);
      }

      return categories;
    });
  }

  Future<void> inserir(CategoryModel tarefa) async {
    final data = {"nome": tarefa.nome, "prioridade": tarefa.prioridade};
    await _db.collection("categories").add(data).then((documentSnaphost) {
      tarefa.key = documentSnaphost.id;
    });
  }

  Future<void> remover(CategoryModel tarefa) async {
    await _db.collection("categories").doc(tarefa.key).delete().then((doc) {});
  }
}
