// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryStore on CategoryStoreBase, Store {
  late final _$tarefasAtom =
      Atom(name: 'CategoryStoreBase.tarefas', context: context);

  @override
  ObservableList<CategoryModel> get tarefas {
    _$tarefasAtom.reportRead();
    return super.tarefas;
  }

  @override
  set tarefas(ObservableList<CategoryModel> value) {
    _$tarefasAtom.reportWrite(value, super.tarefas, () {
      super.tarefas = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'CategoryStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$loadCategoryAsyncAction =
      AsyncAction('CategoryStoreBase.loadCategory', context: context);

  @override
  Future<void> loadCategory() {
    return _$loadCategoryAsyncAction.run(() => super.loadCategory());
  }

  late final _$addCategoryAsyncAction =
      AsyncAction('CategoryStoreBase.addCategory', context: context);

  @override
  Future<void> addCategory(CategoryModel tarefa) {
    return _$addCategoryAsyncAction.run(() => super.addCategory(tarefa));
  }

  late final _$removeCategoryAsyncAction =
      AsyncAction('CategoryStoreBase.removeCategory', context: context);

  @override
  Future<void> removeCategory(int index) {
    return _$removeCategoryAsyncAction.run(() => super.removeCategory(index));
  }

  @override
  String toString() {
    return '''
tarefas: ${tarefas},
loading: ${loading}
    ''';
  }
}
