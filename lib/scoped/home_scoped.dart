import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pattern_scoped_model/model/post_model.dart';
import 'package:pattern_scoped_model/pages/create_page.dart';
import 'package:pattern_scoped_model/pages/update_page.dart';
import 'package:pattern_scoped_model/service/http_service.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScoped extends Model {
  bool isLoading = false;
  List<Post> posts = [];

  void apiPostList() {
    isLoading = true;
    notifyListeners();
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
          _showResponse(response!),
        });
  }

  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();
    var result = await Network.DELETE(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if (result != null) return true;
    isLoading = false;
    notifyListeners();
    return false;
  }

  void _showResponse(String response) {
      var json = jsonDecode(response);
      posts = List<Post>.from(json.map((x) => Post.fromJson(x)));
      isLoading = false;
      notifyListeners();
  }

  void goToCreate(BuildContext context) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreatePage()));
    if (result != null) {
      posts.add(result as Post);
      apiPostList();
    }
  }

  void goToEdit(Post post, BuildContext context) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdatePage(
                  post: post,
                )));
    if (result != null) {
      posts
          .replaceRange(posts.indexOf(post), posts.indexOf(post) + 1, [result]);
      apiPostList();
    }
  }
}
