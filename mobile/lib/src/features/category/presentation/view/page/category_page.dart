import 'package:flutter/material.dart';
import 'package:InLaw/src/theme.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoryPage extends StatelessWidget {
  final String titulo;

  CategoryPage({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      // Restante do conteúdo da página
    );
  }
}
