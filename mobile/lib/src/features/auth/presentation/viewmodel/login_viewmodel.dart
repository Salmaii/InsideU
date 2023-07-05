import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:InLaw/src/features/auth/data/repository/login_repository.dart';
import '../../domain/usecase/login_usecase.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  final error = LoginError();
  final _usecase = Modular.get<LoginUseCase>();

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool isLoading = false;

  @action
  void validateEmail() {
    error.email = _usecase.validateEmail(email);
  }

  @action
  void validatePassword() {
    error.password = _usecase.validatePassword(password, email);
  }

  Future<bool> login() async {
    error.clear();

    validateEmail();
    validatePassword();

    if (!error.hasErrors) {
      isLoading = true;
      try {
        await _usecase.login(email, password);
        return true;
      } on UserNotFoundException catch (e) {
        error.login = 'Usuário não encontrado';
        return false;
      } on InvalidCredentialsException catch (e) {
        error.login = 'A senha está incorreta';
        return false;
      } on Exception catch (e) {
        error.login = 'Algo de errado aconteceu';
        return false;
      } on UnimplementedError {
        error.login = 'Função não implementada!';
        return false;
      } finally {
        isLoading = false;
      }
    } else {
      return false;
    }
  }

  void logout() async {
    clear();
    await FirebaseAuth.instance.signOut();
    Modular.to.pushReplacementNamed('/login/');
  }

  void clear() {
    email = '';
    password = '';
  }
}

class LoginError = _LoginErrorBase with _$LoginError;

abstract class _LoginErrorBase with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  String? login;

  @computed
  bool get hasErrors => email != null || password != null || login != null;

  void clear() {
    email = null;
    password = null;
    login = null;
  }
}
