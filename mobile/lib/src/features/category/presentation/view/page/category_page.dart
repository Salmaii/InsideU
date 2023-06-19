import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final String titulo;

  CategoryPage({required this.titulo});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String categoryDescription = '';

  @override
  void initState() {
    super.initState();
    buscarDescricaoCategoria();
  }

  void buscarDescricaoCategoria() {
    // Aqui você pode implementar a lógica para buscar a descrição da categoria no Firestore do Firebase
    // Usando o widget.titulo para realizar a busca
    // Exemplo:
    // Firestore.instance.collection('categorias').document(widget.titulo).get().then((snapshot) {
    //   setState(() {
    //     categoryDescription = snapshot.data['descricao'];
    //   });
    // });
    // Lembre-se de importar o pacote necessário para acessar o Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryDescription,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
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
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Caso',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Anexos',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode implementar a lógica para enviar a solicitação
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
