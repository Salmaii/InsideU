import 'package:InLaw/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../../viewmodel/login_viewmodel.dart';
import 'package:InLaw/src/common/form_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends ModularState<ForgotPasswordPage, LoginViewModel> {
  // TODO ForgotPasswordViewModel
  late ThemeData _theme;

  Widget get _pageName => SizedBox(
        width: double.infinity,
        height: 60,
        child: Text(
          'Password Recovery'.i18n(),
          style: kTitleBlack,
          textAlign: TextAlign.center,
        ),
      );

  Widget get _loadingIndicator => Visibility(
        child: const LinearProgressIndicator(
          backgroundColor: Colors.blueGrey,
        ),
        visible: store.isLoading,
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

  Widget get _recoverPasswordButton => Container(
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
          //onPressed: store.isLoading ? null : () {store.login, pop},
          // TODO Modular.to.pop('')
          // TODO Navigator.pop(context);
          onPressed: store.isLoading ? null : store.login,
          child: Text('send_email'.i18n()),
        ),
      );

  Widget get _backToLoginButton => Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        width: double.infinity,
        height: 56,
        child: TextButton(
          style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
          onPressed: store.isLoading
              // TODO Trocar para Modular.to.pop('')
              ? null
              : () {
                  Navigator.pop(
                    context,
                  );
                },
          child: Text('already_have_an_account'.i18n()),
        ),
      );

  Widget get _formBuild => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 5),
          _pageName,
          _email,
          _recoverPasswordButton,
          _backToLoginButton, // voltar para o login
          _loadingIndicator,
        ],
      );

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      home: Scaffold(
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
                )),
            child: Observer(builder: (_) {
              return Form(child: _formBuild);
            }),
          )),
        ),
      ),
    );
  }
}
