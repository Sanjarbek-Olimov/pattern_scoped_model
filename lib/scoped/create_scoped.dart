import 'package:flutter/material.dart';
import 'package:pattern_scoped_model/model/post_model.dart';
import 'package:pattern_scoped_model/service/http_service.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateScoped extends Model {
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void saveAndExit(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();

    Post postCreate = Post(title: title, body: body, userId: title.hashCode);
    await Network.POST(Network.API_CREATE, Network.paramsCreate(postCreate));
    Navigator.pop((context), postCreate);
    isLoading = false;
    notifyListeners();
  }
}
