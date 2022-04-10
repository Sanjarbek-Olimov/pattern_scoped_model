import 'package:flutter/material.dart';
import 'package:pattern_scoped_model/scoped/home_scoped.dart';
import 'package:pattern_scoped_model/views/item_of_posts.dart';
import 'package:scoped_model/scoped_model.dart';

import 'create_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeScoped scoped = HomeScoped();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scoped.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scoped Model"),
        centerTitle: true,
      ),
      body: ScopedModel<HomeScoped>(
        model: scoped,
        child: ScopedModelDescendant<HomeScoped>(builder: (BuildContext context, Widget? child, Model model) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: scoped.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return itemOfPosts(scoped.posts[index], scoped, context);
                },
              ),
              scoped.isLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Container(),
            ],
          );
        },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scoped.goToCreate(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
