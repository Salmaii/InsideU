import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _showSearchBar = false;
  List<String> notifications = [
    'Notificação 1',
    'Notificação 2',
    'Notificação 3',
    'Notificação 4',
    'Notificação 5',
    'Notificação 6',
  ];
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remover o ícone de voltar
        backgroundColor: _showSearchBar ? Colors.white : Color(0xFF011C2E),
        title: _showSearchBar
            ? Container(
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Pesquisar',
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onChanged: (value) {
                          // TODO Implementar lógica da pesquisa
                        },
                      ),
                    ),
                    if (_showSearchBar)
                      IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            _showSearchBar = false;
                            _searchController.clear();
                          });
                        },
                      ),
                  ],
                ),
              )
            : Text('Notifications'),
        actions: [
          if (!_showSearchBar)
            IconButton(
              icon: Icon(Icons.filter_alt),
              onPressed: () {
                setState(() {
                  _showSearchBar = !_showSearchBar;
                });
              },
            ),
          SizedBox(width: 16),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
            onTap: () {
              _showCustomNotification(context, notifications[index]);
            },
          );
        },
      ),
    );
  }

  void _showCustomNotification(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
