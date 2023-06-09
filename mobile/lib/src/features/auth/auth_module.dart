import 'package:flutter_modular/flutter_modular.dart';
import 'package:InLaw/src/features/home/home_module.dart';

import 'presentation/view/page/login_page.dart';
import 'data/repository/login_repository.dart';
import 'domain/repository/login_interface.dart';
import 'domain/usecase/login_usecase.dart';
import 'presentation/viewmodel/login_viewmodel.dart';

import 'presentation/view/page/signup_page.dart';
import 'data/repository/sign_up_repository.dart';
import 'domain/repository/sign_up_interface.dart';
import 'domain/usecase/sign_up_usecase.dart';
import 'presentation/viewmodel/sign_up_viewmodel.dart';

import 'package:InLaw/src/features/auth/presentation/view/page/forgot_password_page.dart';
import 'domain/usecase/forgot_password_usecase.dart';
import 'presentation/viewmodel/forgot_password_viewmodel.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => LoginViewModel()),
        Bind.factory((i) => LoginUseCase()),
        Bind.factory<ILogin>((i) => LoginRepository()),
        Bind.factory((i) => SignUpViewModel()),
        Bind.factory((i) => SignUpUseCase()),
        Bind.factory<ISignUp>((i) => SignUpRepository()),
        Bind.factory((i) => ForgotPasswordViewModel()),
        Bind.factory((i) => ForgotPasswordUseCase()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const LoginPage()),
        ChildRoute('/signup', child: (_, __) => const SignUpPage()),
        ChildRoute('/forgotPassword',
            child: (_, __) => const ForgotPasswordPage()),
        ModuleRoute('/home/', module: HomeModule()),
      ];
}
