import 'package:InLaw/src/common/form_text_field.dart';
import 'package:InLaw/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:InLaw/src/features/auth/presentation/viewmodel/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginViewModel> {
  late ThemeData _theme;

  Widget get _loadingIndicator => Visibility(
        child: const LinearProgressIndicator(
          backgroundColor: Colors.blueGrey,
        ),
        visible: store.isLoading,
      );

  Widget get _logo => SizedBox(
        height: 130,
        width: 130,
        child: Image.asset('lib/assets/images/logoImage.png'),
      );

  Widget get _email => widget.createFormField(
        title: 'email'.i18n(),
        theme: _theme,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        hint: 'email_hint'.i18n(),
        enabled: !store.isLoading,
        errorText: store.error.email,
        onChange: (value) => store.email = value,
      );

  Widget get _password => widget.createFormField(
        title: 'password'.i18n(),
        theme: _theme,
        keyboardType: TextInputType.text,
        obscureText: true,
        hint: 'password_hint'.i18n(),
        enabled: !store.isLoading,
        errorText: store.error.password,
        onChange: (value) => store.password = value,
      );

  Widget get _loginButton => Container(
        margin: const EdgeInsets.fromLTRB(30, 15, 30, 5),
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          onPressed: store.isLoading
              ? null
              : () {
                  // TODO Utilizar função correta
                  // Correct Function !
                  // var validateLogin = store.login();
                  // Mail: inside.u.dev@gmail.com
                  // password InsideU@dev2023

                  // Função de teste
                  Modular.to.pushReplacementNamed('/home/');
                },
          child: Text('login'.i18n()),
        ),
      );

  Widget get _forgotPasswordButton => Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        width: double.infinity,
        height: 56,
        child: TextButton(
          style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
          onPressed: store.isLoading
              ? null
              : () {
                  Modular.to.pushNamed('/login/forgotPassword');
                },
          child: Text('forgot_password'.i18n()),
        ),
      );

  Widget get _signUp => Container(
        margin: const EdgeInsets.fromLTRB(30, 40, 30, 30),
        height: 56,
        width: double.infinity,
        child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          onPressed: store.isLoading
              ? null
              : () {
                  Modular.to.pushNamed('/login/signup');
                },
          child: Text('signup'.i18n()),
        ),
      );

  Widget get _divider => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(
              child: Divider(thickness: 1, indent: 25, endIndent: 10)),
          Text(
            'divider_text'.i18n(),
            style: _theme.textTheme.titleLarge,
          ),
          const Expanded(
            child: Divider(
              thickness: 1,
              indent: 10,
              endIndent: 25,
            ),
          ),
        ],
      );

  Widget get _errorMessage => Center(
        child: Text(
          store.error.login ?? '',
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
      );

  Widget get _formBuild => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 5),
          Center(
            child: _logo,
          ),
          const SizedBox(height: 5),
          _email,
          _password,
          _loginButton,
          _forgotPasswordButton,
          _errorMessage,
          _divider,
          _signUp,
          _loadingIndicator,
        ],
      );

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(centerTitle: true, title: const Text('InLaw')),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.88,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Observer(builder: (_) {
              return Form(child: _formBuild);
            }),
          ),
        ),
      ),
    );
  }
}
