import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/usecase/forgot_password_usecase.dart';

part 'forgot_password_viewmodel.g.dart';

class ForgotPasswordViewModel = _ForgotPasswordViewModelBase
    with _$ForgotPasswordViewModel;

abstract class _ForgotPasswordViewModelBase with Store {
  final error = ForgotPasswordError();
  final _usecase = Modular.get<ForgotPasswordUseCase>();

  @observable
  String email = '';

  @observable
  bool isLoading = false;

  @action
  void validateEmail() {
    error.email = _usecase.validateEmail(email);
  }

  void forgot_password(BuildContext context) async {
    error.clear();

    validateEmail();

    if (!error.hasErrors) {
      isLoading = true;

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        _showCustomNotification(context, 'Email enviado com sucesso!');
      } catch (e) {
        print('Erro ao redefinir a senha: $e');
        throw Exception('Erro ao redefinir a senha: $e');
      } finally {
        isLoading = false;
      }
    }
  }

  void _showCustomNotification(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // Modular.to.pop();
          },
        ),
      ),
    );
  }
}

class ForgotPasswordError = _ForgotPasswordErrorBase with _$ForgotPasswordError;

abstract class _ForgotPasswordErrorBase with Store {
  @observable
  String? email;

  @observable
  String? forgot_password;

  @computed
  bool get hasErrors => email != null || forgot_password != null;

  void clear() {
    email = null;
    forgot_password = null;
  }
}
