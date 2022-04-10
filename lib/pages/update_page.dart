import 'package:flutter/material.dart';
import 'package:pattern_scoped_model/model/post_model.dart';
import 'package:pattern_scoped_model/scoped/update_scoped.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdatePage extends StatefulWidget {
  static const String id = "update_page";

  Post post;

  UpdatePage({Key? key, required this.post}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  UpdateScoped scoped = UpdateScoped();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scoped.post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UpdateScoped>(
        model: scoped,
        child: ScopedModelDescendant<UpdateScoped>(
          builder: (BuildContext context, Widget? child, Model model) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Update post"),
                centerTitle: true,
                actions: [
                  TextButton(
                      onPressed: () {
                        scoped.saveAndExit(context);
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ))
                ],
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: scoped.titleController
                              ..text = scoped.post.title!,
                            maxLines: null,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(bottom: 10, top: 10),
                                hintText: "Title"),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: scoped.bodyController
                              ..text = scoped.post.body!,
                            maxLines: null,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: "Body",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  scoped.isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : Container(),
                ],
              ),
            );
          },
        ));
  }
}
