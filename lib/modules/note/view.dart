import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:treefuckers/modules/note/components/pick_file.dart';
import 'package:treefuckers/repositories/user.dart';

import '../../enums/notetype.dart';
import '../../repositories/note.dart';

final _choiceChip = StateProvider<int>((ref) {
  return 0;
});

final _noteProvider = StateProvider<Note>(
  (ref) {
    return Note.empty();
  },
);

class NoteView {
  static Widget create() => _NoteCreateView();
  static Widget read() => _NoteReadView();
}

class _NoteCreateView extends ConsumerWidget {
  _NoteCreateView({super.key});
  GlobalKey<FormState> noteFormKey = GlobalKey<FormState>();
  TextEditingController noteTextController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final note = ref.watch(_noteProvider);
    final typeSelected = ref.watch(_choiceChip);
    return Scaffold(
        body: SafeArea(
      child: Form(
        child: Column(
          children: [
            Text("type"),
            Wrap(
                children: List.generate(
                    NoteType.values.length,
                    (index) => ChoiceChip(
                          onSelected: (value) =>
                              ref.read(_choiceChip.notifier).state = index,
                          label: Text(NoteType.values[index].toString()),
                          selected:
                              ref.read(_choiceChip) == index ? true : false,
                        ))),
            ref.read(_choiceChip.notifier).state == 0
                ? Column(
                    children: [
                      Text("Text:"),
                      TextFormField(
                        validator: noteTextValidator,
                        decoration: InputDecoration(hintText: "Note:"),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text("File:"),
                      PickFileWidget(file: note.arData)
                    ],
                  ),
            TextButton(
                onPressed: () => submit(ref, context), child: Text("submit"))
          ],
        ),
      ),
    ));
  }

  void submit(WidgetRef ref, BuildContext context) async {
    if (noteFormKey.currentState!.validate()) {
      Note note = Note(
          author: ref.read(userProvider.notifier).data,
          type: ref.read(_choiceChip.notifier).state == 0
              ? NoteType.String
              : NoteType.AR,
          textData:
              noteTextController.text.isEmpty ? null : noteTextController.text,
          arData: ref.read(_noteProvider.notifier).state.arData == null
              ? null
              : ref.read(_noteProvider.notifier).state.arData);
      NoteRepository(data: [note]).push(context);
      Navigator.of(context).pop();
    }
  }

  String? noteTextValidator(String? value) {
    if (value == null || value.isEmpty) return "Can't be empty";
  }
}

class _NoteReadView extends ConsumerStatefulWidget {
  const _NoteReadView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __NoteReadViewState();
}

class __NoteReadViewState extends ConsumerState<_NoteReadView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
