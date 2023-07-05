import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:InLaw/firebase_options.dart';
import 'package:InLaw/src/services/send_categories.dart';

import 'app_module.dart';
import 'app_widget.dart';

void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Verificar se há categorias no banco de dados
    bool hasCategories = await checkCategories();

    // Se não houver categorias, enviar as categorias
    if (!hasCategories) {
      await sendCategories();
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : FutureBuilder(
                future: Future.delayed(Duration(seconds: 1)),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    WidgetsBinding widgetsBinding =
                        WidgetsFlutterBinding.ensureInitialized();

                    FlutterNativeSplash.preserve(
                        widgetsBinding: widgetsBinding);
                    return ModularApp(
                        module: AppModule(), child: const AppWidget());
                  }
                },
              ),
      ),
    );
  }
}
