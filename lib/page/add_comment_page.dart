import 'package:crud_sqlite_api/data/models/comment/comments_model.dart';
import 'package:flutter/material.dart';
import 'package:crud_sqlite_api/componentes/snack_message.dart';
import 'package:crud_sqlite_api/data/repository/comment/comment_api_repositorys.dart';

class AddCommentPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddCommentPage> {
  final _formKey = GlobalKey<FormState>();

  // Instance Repository
  CommentApiRepositoryImpl commentApiRepositoryImpl = CommentApiRepositoryImpl();

  // Inputs
  final nameController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              validator: (value) {
                return value.isEmpty ? 'El campo name no puede estar vacio' : null;
              },
              decoration: InputDecoration(
                hintText: 'Insert nombre',
                icon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              controller: bodyController,
              validator: (value) {
                return value.isEmpty ? 'El comentario no puede estar vacio' : null;
              },
              decoration: InputDecoration(
                hintText: 'Insert comentario',
                icon: Icon(Icons.info),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              child: Text('Guardar'),
              onPressed: () {
                if (_formKey.currentState.validate()) {

                 setState(() {
                   // create comment
                   commentApiRepositoryImpl.createComment(CommentsModel(
                       name: nameController.text,
                       body: bodyController.text
                   ));
                 });

                  Scaffold.of(context).showSnackBar(snackMessage('El Comentario ${nameController.text} ha sido guardado'));
                  _formKey.currentState?.reset();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
