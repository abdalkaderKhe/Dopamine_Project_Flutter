import 'package:eisenhower_matrix/model/db/database_model.dart';

final String tableNotes = 'notes';

class NoteFields {
  static final String id = 'id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Note implements DatabaseModel{
  int? id;
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  late DateTime createdTime;

  Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  Note.fromMap(Map<String,dynamic> map){
    id = map[NoteFields.id];
    title = map[NoteFields.title] as String;
    number = map[NoteFields.number] as int;
    isImportant = map[NoteFields.isImportant] == 1;
    description = map[NoteFields.description] as String;
    createdTime = DateTime.parse(map[NoteFields.time] as String);
  }

  @override
  String? database() {
    return "todos_db";
  }

  @override
  int? getId() {
    return this.id;
  }

  @override
  String? table() {
    return "notes";
  }

  @override
  Map<String, dynamic>? toMap() {
    return {
      NoteFields.id : id,
      NoteFields.isImportant : isImportant ? 1 : 0,
      NoteFields.number : number,
      NoteFields.title : title,
      NoteFields.description: description,
      NoteFields.time : createdTime.toIso8601String(),
    };
  }
}