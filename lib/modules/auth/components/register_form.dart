import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:treefuckers/main.dart';
import 'package:treefuckers/repositories/user.dart';

import '../../home/view.dart';

class RegisterView extends HookConsumerWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  PageController controller;
  RegisterView({super.key, required this.controller});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Center(
      child: Form(
        key: registerFormKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              autocorrect: false,
              decoration: InputDecoration(labelText: "username"),
              onChanged: (_) => registerFormKey.currentState!.validate(),
              validator: usernameValidator,
              controller: usernameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "username"),
              autocorrect: false,
              onChanged: (_) => registerFormKey.currentState!.validate(),
              validator: passwordValidator,
              controller: passwordController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "username"),
              autocorrect: false,
              onChanged: (_) => registerFormKey.currentState!.validate(),
              validator: passwordConfirmValidator,
              controller: passwordConfirmController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () =>
                    auth(context, ref, usernameController, passwordController),
                child: const Text("register")),
          ),
          TextButton(
              onPressed: () => controller.previousPage(
                  duration: Duration(milliseconds: 125),
                  curve: Curves.easeInOut),
              child: Text('auth'))
        ]),
      ),
    );
  }

  Future<void>? auth(
      BuildContext context,
      WidgetRef ref,
      TextEditingController usernameController,
      TextEditingController passwordController) async {
    if (registerFormKey.currentState!.validate()) {
      ref.watch(userProvider.notifier).update(
          updated: UserRepository(
              data: User(
                  id: "01",
                  username: usernameController.text,
                  age: -1,
                  password: passwordController.text)));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
    }
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return "can't be empty";
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return "can't be empty";
  }

  String? passwordConfirmValidator(String? value) {
    if (value == null || value.isEmpty) return "can't be empty";
    if (value != passwordController.text)
      return "password and confirmation fields must be the same";
  }
}
