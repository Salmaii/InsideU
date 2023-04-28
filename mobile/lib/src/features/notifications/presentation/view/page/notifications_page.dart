import 'package:InLaw/src/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:InLaw/src/theme.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Notifications'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.edit),
      //       onPressed: () {
      //         // Adicione aqui a lógica para permitir ao usuário editar seu perfil.
      //       },
      //     ),
      //   ],
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 75,
            backgroundColor: Colors.amberAccent,
            // backgroundImage: AssetImage('lib/assets/images/logoImage.png'),
          ),
          SizedBox(height: 16),
          Text(
            'Nome do usuário',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Outras informações relevantes do perfil',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
