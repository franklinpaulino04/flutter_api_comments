import 'package:flutter/material.dart';

import 'add_comment_page.dart';
import 'list_comment_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _menuItems = [
    {'label': 'Agregar Comentarios', 'route': 0},
    {'label': 'Listar Comentarios', 'route': 1},
  ];

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Comentarios con Api'),
      ),
      body: _getContentWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {},
      ),
      drawer: Drawer(
        child: ListView(children: _menu(context)),
      ),
    );
  }

  Widget _menuHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        //color: Colors.deepOrange,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.5, 0.8, 0.9],
            colors: [Colors.blue, Colors.green, Colors.orange, Colors.red]),
      ),
      child: Center(
        child: CircleAvatar(
          radius: 60.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
            'https://www.fivesquid.com/pics/t2/1568868712-108802-1-1.jpg',
          ),
        ),
      ),
    );
  }

  Widget menuItem(BuildContext context, Map item) {
    return ListTile(
      title: Text(item['label']),
      leading: Icon(Icons.play_circle_outline),
      onTap: () {
        setState(() {
          print(item['route']);
          _selectedPage = item['route'];
          Navigator.pop(context);
        });
      },
    );
  }

  List<Widget> _menu(BuildContext context) {
    List<Widget> list = List<Widget>();
    list.add(_menuHeader());
    for (Map it in _menuItems) {
      list.add(menuItem(context, it));
    }
    return list;
  }

  Widget _getContentWidget() {
    switch (_selectedPage) {
      case 0:
        return AddCommentPage();
      case 1:
        return ListCommentPage();
      case 2:
        return null;

      default:
        return Center(
            child: Text(
          "Error",
          style: TextStyle(fontSize: 32.0, color: Colors.red),
        ));
    }
  }
}
