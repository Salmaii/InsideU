import 'package:flutter/material.dart';
import 'package:InLaw/src/common/form_text_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../../viewmodel/sign_up_viewmodel.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpViewModel> {
  late ThemeData _theme;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  Widget get _loadingIndicator => Visibility(
        child: const LinearProgressIndicator(
          backgroundColor: Colors.blueGrey,
        ),
        visible: store.isLoading,
      );

  Widget get _name => widget.createFormField(
        title: 'name'.i18n(),
        theme: _theme,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        hint: 'name_hint'.i18n(),
        enabled: !store.isLoading,
        errorText: store.error.name,
        onChange: (value) => store.name = value,
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

  Widget get _signUpButton => Container(
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
              : () async {
                  Future<bool> success = store.signUp();
                  if (await success) {
                    _showSnackBar('User created successfully');
                    Modular.to.pushReplacementNamed('/login/');
                  }
                },
          child: Text('signup'.i18n()),
        ),
      );

  Widget get _backToLoginButton => Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        width: double.infinity,
        height: 56,
        child: TextButton(
          style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
          onPressed: store.isLoading
              ? null
              : () {
                  Modular.to.pop();
                },
          child: Text('already_have_an_account'.i18n()),
        ),
      );

  Widget get _errorMessage => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          store.error.signUp ?? '',
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
          _name,
          _email,
          _password,
          _errorMessage,
          _signUpButton,
          _backToLoginButton,
          _loadingIndicator,
        ],
      );

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _dismissKeyboard(BuildContext context) {
    _focusScopeNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          _dismissKeyboard(context);
        },
        child: FocusScope(
          node: _focusScopeNode,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top,
                ),
                color: Colors.white,
                child: Observer(builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Form(child: _formBuild),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
