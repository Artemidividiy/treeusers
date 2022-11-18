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
    return ref.watch(awaitingInitializerProvider).when(
        data: (data) {
          if (!data['isServerConnected']!)
            return Scaffold(body: Center(child: Text("no treeserver found")));
          if (!data['isUserLoaded']!)
            return AuthView();
          else
            return HomeView();
        },
        error: (obj, trace) => Scaffold(
              body: Center(
                child: Text("$obj + $trace"),
              ),
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
