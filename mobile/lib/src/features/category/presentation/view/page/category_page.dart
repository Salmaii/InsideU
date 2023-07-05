import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoryPage extends StatefulWidget {
  final String titulo;

  CategoryPage({required this.titulo});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String categoriaDescricao = '';
  IconData? categoriaIcone;
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    buscarDescricaoCategoria();
  }

  void buscarDescricaoCategoria() {
    FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.titulo)
        .get()
        .then((snapshot) {
      setState(() {
        categoriaDescricao = snapshot.data()!['description'];
        categoriaIcone = IconsHelper.getIconData(snapshot.data()!['icon']);
      });
    });
  }

  void enviarDadosParaFirestore() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      final titulo = tituloController.text;
      final descricao = descricaoController.text;
      final categoria = widget.titulo;

      final caseData = {
        'userId': userId,
        'titulo': titulo,
        'descricao': descricao,
        'categoria': categoria,
        'status': 'aberto',
        'data': DateTime.now(),
      };

      FirebaseFirestore.instance.collection('cases').add(caseData);
    }
  }

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Caso enviado com sucesso!'),
      ),
    );
  }

  void validateFields() {
    final titulo = tituloController.text;
    final descricao = descricaoController.text;
    setState(() {
      isButtonDisabled = titulo.isEmpty || descricao.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    categoriaIcone,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      categoriaDescricao,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Formulário de Solicitação:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  TextFormField(
                    controller: tituloController,
                    onChanged: (value) {
                      validateFields();
                    },
                    decoration: InputDecoration(
                      labelText: 'Título do Caso',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: descricaoController,
                    onChanged: (value) {
                      validateFields();
                    },
                    decoration: InputDecoration(
                      labelText: 'Descrição do Caso',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 10,
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: isButtonDisabled
                          ? null
                          : () {
                              enviarDadosParaFirestore();
                              _showSnackbar(context);
                              Modular.to.pop();
                            },
                      child: Text('Enviar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconsHelper {
  static IconData? getIconData(String iconName) {
    switch (iconName) {
      case 'security':
        return Icons.security;
      case 'gavel':
        return Icons.gavel;
      case 'account_balance':
        return Icons.account_balance;
      case 'work':
        return Icons.work;
      case 'business':
        return Icons.business;
      case 'eco':
        return Icons.eco;
      case 'create':
        return Icons.create;
      case 'family_restroom':
        return Icons.family_restroom;
      case 'public':
        return Icons.public;
      case 'attach_money':
        return Icons.attach_money;
      case 'home':
        return Icons.home;
      case 'computer':
        return Icons.computer;
      case 'category':
        return Icons.category;
      default:
        return Icons.help;
    }
  }
}
