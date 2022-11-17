import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:treefuckers/main.dart';
import 'package:treefuckers/repositories/user.dart';

import '../note/view.dart';

class HomeView extends HookConsumerWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 160,
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton.icon(
              style: Theme.of(context).textButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).secondaryHeaderColor)),
              label: Text("log out"),
              onPressed: () async =>
                  ref.watch(userProvider.notifier).logout(context),
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => createNote(context), label: Text("Create Note")),
        body: Column(
          children: [Text(user.data.toString())],
        ));
  }

  void createNote(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NoteView.create()));
  }
}
