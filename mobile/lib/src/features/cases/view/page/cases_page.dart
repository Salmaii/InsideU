import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class CaseListPage extends StatefulWidget {
  @override
  _CaseListPageState createState() => _CaseListPageState();
}

class _CaseListPageState extends State<CaseListPage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> casesStream;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      casesStream = FirebaseFirestore.instance
          .collection('cases')
          .where('userId', isEqualTo: userId)
          .snapshots();
    }
  }

  Future<void> _showCaseDetailsDialog(BuildContext context, String titulo,
      String descricao, String categoria, Timestamp data) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cases')
        .where('titulo', isEqualTo: titulo)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final caseData = snapshot.docs.first.data();
      final categoria = caseData['categoria'];

      final formattedDate = DateFormat('dd/MM/yyyy').format(data.toDate());

      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: Text('Detalhes do Caso'),
            content: Container(
              constraints: BoxConstraints(minWidth: 900, maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$titulo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text('$categoria'),
                  SizedBox(height: 8.0),
                  Text('Data: $formattedDate'),
                  SizedBox(height: 8.0),
                  Container(
                    height: 200.0,
                    child: SingleChildScrollView(
                      child: Text(
                        '$descricao',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _deleteCase(String casoId) async {
    try {
      await FirebaseFirestore.instance.collection('cases').doc(casoId).delete();
    } catch (e) {
      print('Erro ao deletar caso: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Casos'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: casesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ocorreu um erro ao carregar os casos.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Nenhum caso encontrado.'),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final casoId = doc.id;
              final titulo = doc['titulo'];
              final descricao = doc['descricao'];
              final categoria = doc['categoria'];
              final data = doc['data'] as Timestamp;

              final titleWithCategory = '$titulo';

              return Dismissible(
                key: Key(casoId),
                background: Container(
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 16.0),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  _deleteCase(casoId);
                },
                child: Card(
                  child: ListTile(
                    onTap: () {
                      _showCaseDetailsDialog(
                          context, titulo, descricao, categoria, data);
                    },
                    title: Text(
                      titleWithCategory,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: Text(
                      descricao,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      categoria,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
