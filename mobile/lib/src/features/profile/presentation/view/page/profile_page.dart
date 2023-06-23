import 'package:flutter/material.dart';
import 'package:InLaw/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, LoginViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _descricaoController = TextEditingController();
  bool _isEditing = false;
  late String _currentDescricao;
  CollectionReference _casesCollection =
      FirebaseFirestore.instance.collection('cases');

  @override
  void initState() {
    super.initState();
    _currentDescricao = '';
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference _usersCollection =
        FirebaseFirestore.instance.collection('users');

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: _isEditing ? Colors.grey[300] : Color(0xFF011C2E),
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(user?.displayName ?? ''),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = true;
                _descricaoController.text = _currentDescricao;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: store.isLoading
                ? null
                : () {
                    var logout = store.logout();
                  },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFF011C2E),
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: store.isLoading
                  ? null
                  : () {
                      var logout = store.logout();
                    },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: _usersCollection.doc(user!.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final profileData = snapshot.data!.data() as Map<String, dynamic>;
              final casosAbertos = profileData['casos']
                      ?.where((caso) => caso['status'] == 'aberto')
                      .toList()
                      ?.length ??
                  0;
              final casosFechados = profileData['casosFechados'] ?? 0;
              final descricao = profileData['descricao'] ?? '';

              _currentDescricao = descricao;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 150,
                    color: Colors.amberAccent,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.displayName ?? '',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Casos Abertos',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          StreamBuilder<QuerySnapshot>(
                            stream: _casesCollection
                                .where('userId', isEqualTo: user.uid)
                                .where('status', isEqualTo: 'aberto')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final openCases = snapshot.data!.docs;
                                final casosAbertosCount = openCases.length;
                                return Text(
                                  casosAbertosCount.toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Casos Fechados',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            casosFechados.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (!_isEditing)
                    Text(
                      _currentDescricao,
                      style: TextStyle(fontSize: 16),
                    )
                  else
                    TextFormField(
                      controller: _descricaoController,
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isEditing)
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isEditing = false;
                              _descricaoController.text = _currentDescricao;
                            });
                          },
                          icon: Icon(Icons.cancel),
                          color: Colors.red,
                        ),
                      if (_isEditing)
                        IconButton(
                          onPressed: () {
                            _updateProfileDescription(user.uid);
                          },
                          icon: Icon(Icons.save),
                          color: Colors.green,
                        ),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Erro ao carregar perfil');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<void> _updateProfileDescription(String userId) async {
    try {
      String descricao = _descricaoController.text.trim();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'descricao': descricao});

      setState(() {
        _isEditing = false;
        _currentDescricao = descricao;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Descrição atualizada com sucesso')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar descrição')),
      );
    }
  }
}
