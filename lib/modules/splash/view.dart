import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:treefuckers/main.dart';
import 'package:treefuckers/modules/auth/view.dart';
import 'package:treefuckers/modules/home/view.dart';
import 'package:treefuckers/repositories/user.dart';

class SplashView extends StatefulHookConsumerWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(awaitingUsernameProvider).when(
        data: (data) =>
            data == UserRepository.empty() ? AuthView() : HomeView(),
        error: (obj, trace) => Center(
              child: Text("$obj + $trace"),
            ),
        loading: () => Scaffold(
              body: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.eco), Icon(Icons.portrait)],
                ),
              ),
            ));
  }
}
