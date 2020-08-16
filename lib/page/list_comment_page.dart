import 'package:flutter/material.dart';
import 'package:crud_sqlite_api/componentes/message_box.dart';
import 'package:crud_sqlite_api/componentes/snack_message.dart';
import 'package:crud_sqlite_api/data/repository/comment/comment_api_repositorys.dart';
import 'package:crud_sqlite_api/data/models/comment/comments_model.dart';

class ListCommentPage extends StatefulWidget {
  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListCommentPage> {
  final _formKey = GlobalKey<FormState>();

  // Instance Repository
  CommentApiRepositoryImpl commentApiRepositoryImpl = CommentApiRepositoryImpl();

  // Inputs
  final nameController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CommentsModel>>(
      future: commentApiRepositoryImpl.getComments(),
      builder: (BuildContext context, AsyncSnapshot<List<CommentsModel>> snapshot) {

        if (snapshot.hasError) {
            return Text('Error al cargar los datos');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return new ListView(
          children: _listaMapCommentss(context, snapshot.data),
        );
      },
    );
  }

  List<Widget> _listaMapCommentss(BuildContext context, List<CommentsModel> comments) {

    return (comments != null) ? comments.map((_comment) {
      return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.redAccent,
          child: Row(
            children: [
              Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'ELIMINAR',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          color: Colors.greenAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'ACTUALIZAR',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(Icons.edit,
                color: Colors.white,
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            _delete(_comment, _comment.id.toString());

          } else if (direction == DismissDirection.endToStart) {
            _update(_comment, _comment.id.toString());
          }
        },
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: Colors.black26,
              ),
              title: Text('${_comment.name} (${_comment.body.toString()})'),
              subtitle: Text('ID: ${_comment.id} ${" " * 10} Comentario: ${_comment.body.toLowerCase()}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            Divider(
              thickness: 2.0,
              color: Colors.lightBlue,
              indent: 70.0,
              endIndent: 20.0,
            )
          ],
        ),
      );
    }).toList() : [];
  }

  void _delete(CommentsModel comment, String docId) {
    messageBox(
        context: context,
        icon: Icons.delete_forever,
        title: '¿Eliminara el comentario?',
        content: Text('${comment.name.toUpperCase()}'),
        onPressOkBtn: () {
          // delete comment
          setState(() {
            commentApiRepositoryImpl.deleteComment(comment);
          });

          Navigator.of(context).pop();
        },
        onPressCancelBtn: () {
          setState(() {});
          Navigator.of(context).pop();
        });
  }

  void _update(CommentsModel comment, String docId) {
    nameController.text = comment.name;
    bodyController.text = comment.name;

    Widget form = Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: nameController,
              validator: (value) {
                return value.isEmpty ? 'El campo name no puede estar vacio' : null;
              },
              decoration: InputDecoration(
                hintText: 'Insert username',
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
                hintText: 'Insert lastname',
                icon: Icon(Icons.info_outline),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              child: Text('Actualizar'),
              onPressed: () {
                if (_formKey.currentState.validate()) {

                  setState(() {
                    // update comment
                    commentApiRepositoryImpl.updateComment(comment);
                  });

                  Scaffold.of(context).showSnackBar(snackMessage('El comentario ${nameController.text} ha sido actualizado'));
                  _formKey.currentState?.reset();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );

    messageBox(
      context: context,
      icon: Icons.edit,
      title: 'Actualizar comentario',
      content: form,
      onPressCancelBtn: () {
        setState(() {});
        Navigator.of(context).pop();
      },
    );
  }
}
