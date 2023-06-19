import 'package:mobx/mobx.dart';
import '../services/db_service.dart';
import '../store/category_model.dart';

part 'category_store.g.dart';

class CategoryStore = CategoryStoreBase with _$CategoryStore;

abstract class CategoryStoreBase with Store {
  final _database = DbService();

  @observable
  ObservableList<CategoryModel> tarefas = <CategoryModel>[].asObservable();

  @observable
  bool loading = false;

  @action
  Future<void> loadCategory() async {
    loading = true;
    tarefas.clear();
    final data = await _database.listar();
    tarefas.addAll(data);
    loading = false;
  }

  @action
  Future<void> addCategory(CategoryModel tarefa) async {
    await _database.inserir(tarefa);
    tarefas.add(tarefa);
  }

  @action
  Future<void> removeCategory(int index) async {
    await _database.remover(tarefas[index]);
    tarefas.removeAt(index);
  }
}
