import 'package:flutter/material.dart';
import 'package:InLaw/src/theme.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoryPage extends StatelessWidget {
  final String titulo;

  const CategoryPage({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Modular.to.pop();
            },
          ),
        ),
        // Restante do conteúdo da página
      ),
    );
  }
}
