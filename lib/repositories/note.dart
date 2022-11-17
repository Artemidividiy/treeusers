import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:treefuckers/enums/notetype.dart';
import 'package:treefuckers/repositories/user.dart';

import 'ar.dart';

class Note {
  NoteType type;
  UserRepository author;
  String? textData;
  File? arData;
  Note(
      {required this.author,
      this.textData,
      this.arData,
      this.type = NoteType.String})
      : assert((textData == null && arData != null) ||
            (type == NoteType.String && textData != null) ||
            (type == NoteType.AR && arData != null));

  Note copyWith({
    UserRepository? author,
    String? textData,
    File? arData,
  }) {
    return Note(
      author: author ?? this.author,
      textData: textData ?? this.textData,
      arData: arData ?? this.arData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author.toMap(),
      'textData': textData,
      'arData': arData?.path,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      author: UserRepository.fromMap(map['author']),
      textData: map['textData'],
      arData: map['arData'] != null ? map['arData'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() =>
      'Note(author: $author, textData: $textData, arData: $arData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.author == author &&
        other.textData == textData &&
        other.arData == arData;
  }

  @override
  int get hashCode => author.hashCode ^ textData.hashCode ^ arData.hashCode;
  factory Note.empty() => Note(
      author: UserRepository.empty(), type: NoteType.String, textData: "empty");
}

class NoteRepository {
  List<Note> data;
  NoteRepository({
    required this.data,
  });

  NoteRepository copyWith({
    List<Note>? data,
  }) {
    return NoteRepository(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory NoteRepository.fromMap(Map<String, dynamic> map) {
    return NoteRepository(
      data: List<Note>.from(map['data']?.map((x) => Note.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteRepository.fromJson(String source) =>
      NoteRepository.fromMap(json.decode(source));

  @override
  String toString() => 'NoteRepository(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteRepository && listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;

  Future<void> push(BuildContext context) async {
    try {} catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("something went wrong")));
    }
  }
}
