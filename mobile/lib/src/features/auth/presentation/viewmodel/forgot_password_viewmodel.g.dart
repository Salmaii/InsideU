// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ForgotPasswordViewModel on _ForgotPasswordViewModelBase, Store {
  late final _$emailAtom =
      Atom(name: '_ForgotPasswordViewModelBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ForgotPasswordViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_ForgotPasswordViewModelBaseActionController =
      ActionController(name: '_ForgotPasswordViewModelBase', context: context);

  @override
  void validateEmail() {
    final _$actionInfo = _$_ForgotPasswordViewModelBaseActionController
        .startAction(name: '_ForgotPasswordViewModelBase.validateEmail');
    try {
      return super.validateEmail();
    } finally {
      _$_ForgotPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
isLoading: ${isLoading}
    ''';
  }
}

mixin _$ForgotPasswordError on _ForgotPasswordErrorBase, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_ForgotPasswordErrorBase.hasErrors'))
          .value;

  late final _$emailAtom =
      Atom(name: '_ForgotPasswordErrorBase.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$forgot_passwordAtom =
      Atom(name: '_ForgotPasswordErrorBase.forgot_password', context: context);

  @override
  String? get forgot_password {
    _$forgot_passwordAtom.reportRead();
    return super.forgot_password;
  }

  @override
  set forgot_password(String? value) {
    _$forgot_passwordAtom.reportWrite(value, super.forgot_password, () {
      super.forgot_password = value;
    });
  }

  @override
  String toString() {
    return '''
email: ${email},
forgot_password: ${forgot_password},
hasErrors: ${hasErrors}
    ''';
  }
}
