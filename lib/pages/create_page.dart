import 'package:flutter/material.dart';
import 'package:pattern_scoped_model/scoped/create_scoped.dart';
import 'package:scoped_model/scoped_model.dart';

class CreatePage extends StatefulWidget {
  static const String id = "create_page";

  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  CreateScoped scoped = CreateScoped();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CreateScoped>(
        model: scoped,
        child: ScopedModelDescendant<CreateScoped>(
          builder: (BuildContext context, Widget? child, Model model) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Create post"),
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
                            controller: scoped.titleController,
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
                            controller: scoped.bodyController,
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
