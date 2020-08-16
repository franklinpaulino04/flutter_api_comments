import 'package:crud_sqlite_api/data/models/comment/comments_model.dart';
import 'package:crud_sqlite_api/data/api/comment/comments_api_service.dart';

// -------------------- REPOSITORY -------------------- //

abstract class CommentApiRepository {

  Future<List<CommentsModel>> getComments();

  Future<CommentsModel> getCommentById(int id);

  Future createComment(CommentsModel comment);

  Future updateComment(CommentsModel comment);

  Future deleteComment(CommentsModel comment);
}

// -------------------- IMPLEMENTS -------------------- //

class CommentApiRepositoryImpl implements CommentApiRepository {

   final CommentsApiService _commentsApiService = CommentsApiService.commentsApiService;

  @override
  Future createComment(comment) {
    try{

     return _commentsApiService.createComment(comment);

    }on Exception catch(exception){
      print(exception);
    }
  }

  @override
  Future deleteComment(comment) {
    try{

     return _commentsApiService.deleteComment(comment);

    }on Exception catch(exception){
      print(exception);
    }
  }

  @override
  Future<CommentsModel> getCommentById(int id) {

    try{

     return _commentsApiService.getCommenById(id);

    }on Exception catch(exception){
      print(exception);
    }
  }

  @override
  Future<List<CommentsModel>> getComments() {

    try{

    return _commentsApiService.getComments();

    }on Exception catch(exception){
      print(exception);
    }
  }

  @override
  Future updateComment(CommentsModel comment) {

   try{

    return _commentsApiService.updateComment(comment);

   }on Exception catch(exception){
     print(exception);
   }
  }
}