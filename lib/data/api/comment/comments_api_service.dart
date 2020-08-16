import 'dart:convert';
import 'package:crud_sqlite_api/config/api_config.dart';
import 'package:crud_sqlite_api/data/models/comment/comments_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class CommentsApiService {
  static final CommentsApiService commentsApiService = CommentsApiService._();

  CommentsApiService._();

  static final String _endpoint = '${CONFIG['API_URL']}comments/';

  Future<List<CommentsModel>> getComments() async {
    final response = await http.get(_endpoint);

    if (response.statusCode == 200){
      return json
          .decode(response.body)
          .map<CommentsModel>((json) => CommentsModel.fromJson(json))
          .toList();
    }else{
      throw Exception("Failed to getComments");
    }
  }

  Future<int> getLengthComment() async {
    final response = await http.get(_endpoint);

    if (response.statusCode == 200) {
      return json.decode(response.body)
                 .map<CommentsModel>((json) => CommentsModel.fromJson(json))
                 .toList()
                 .length;
    } else {
      throw Exception('Failed to LengthComment');
    }
  }

  Future<CommentsModel> getCommenById(int id) async {
    final response = await http.get(_endpoint + id.toString());

    if (response.statusCode == 200) {
      return CommentsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to getBy Comments');
    }
  }

  Future createComment(CommentsModel comment) async {
    final response = await http.post(_endpoint,
        headers: {"Content-Type": "application/json"}, body: json.encode(comment));

    return response.body;
  }

  Future updateComment(CommentsModel comment) async {
    final response = await http.put(_endpoint + comment.id.toString(),
        headers: {"Content-Type": "application/json"}, body: json.encode(comment));

    return response.body;
  }

  Future deleteComment(CommentsModel comment) async {
    final response = await http.delete(_endpoint + comment.id.toString(),
        headers: {"Content-Type": "application/json"});

    return response.body;
  }
}