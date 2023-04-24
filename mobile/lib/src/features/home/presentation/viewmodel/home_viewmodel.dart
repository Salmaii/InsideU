import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecase/home_usecase.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final error = HomeError();
  final _usecase = Modular.get<HomeUseCase>();

  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  bool isLoading = false;

  @action
  void validateName() {
    error.name = _usecase.validateName(name);
  }

  @action
  void validateEmail() {
    error.email = _usecase.validateEmail(email);
  }

  void home() async {
    error.clear();

    validateName();
    validateEmail();

    if (!error.hasErrors) {
      isLoading = true;
      try {
        await _usecase.home(name, email);
        //page to 
      } on UnimplementedError {
        // TODO: Fix!!!
        error.home = 'Função não implementada!';
      } finally {
        isLoading = false;
      }
    }
  }
}

class HomeError = _HomeErrorBase with _$HomeError;

abstract class _HomeErrorBase with Store {

  @observable
  String? name;

  @observable
  String? email;

  @observable
  String? home;

  @computed
  bool get hasErrors => name != null || email != null || home != null;

  void clear() {
    name = null;
    email = null;
    home = null;
  }
}