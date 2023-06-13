import 'package:InLaw/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:InLaw/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, LoginViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // class _LoginPageState extends ModularState<LoginPage, LoginViewModel> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF011C2E),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text('username'),
          ),
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
                    // TODO Add functionalities
                    ListTile(
                      title: const Text('Opção 1'),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Opção 2'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              ListTile(
                title:
                    const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: store.isLoading
                    ? null
                    : () {
                        var logout = store.logout();
                        // Navigator.pushNamed(context, "/home/");
                      },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 75,
                backgroundColor: Colors.amberAccent,
                // backgroundImage: AssetImage('assets/images/logo.png'),
              ),
              const SizedBox(height: 16),
              Text(
                'Nome do usuário',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Outras informações relevantes do perfil',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
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
                      Text(
                        '0',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
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
                        '0',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
