import 'dart:convert';
import 'package:eisenhower_matrix/model/db/database_model.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/sub_todo.dart';

const String toDosUrgentAndImportantTable = 'ToDosUrgentAndImportantTable';
const String toDosUrgentAndUnimportantTable = 'ToDosUrgentAndUnimportantTable';
const String toDosNotUrgentAndImportantTable = 'ToDosNotUrgentAndImportantTable';
const String toDosNotUrgentNotImportantTable = 'ToDosNotUrgentNotImportantTable';
const String toDayToDosDayTable = 'ToDayToDosDayTable';

class TodosFiled
{
  static const String id = 'id';
  static const String title = 'title';
  static const String details = 'details';
  static const String category = 'category';
  static const String isDone = 'isDone';
  static const String toDoTime = 'toDoTime';
  static const String remind = 'remind';
  static const String tableName = 'tableName';
  static const String parentToDoName = 'parentToDoName';
}

class ToDo implements DatabaseModel
{
  int? id;
  late String title;
  late String? details;
  late String? category;
  late bool isDone;
  late DateTime? toDoTime;
  late DateTime? remind;
  late String tableName;
  List<SubToDo> subTodos = [];

  ToDo(
    {
    required this.title,
    required this.details,
    required this.category,
    required this.toDoTime,
    required this.remind,
    required this.isDone,
    required this.tableName,
    required this.subTodos,
  });



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
    return tableName;
  }

  @override
  Map<String, dynamic>? toMap()
  {
    return {
      TodosFiled.id: id,
      TodosFiled.title: title,
      TodosFiled.isDone: isDone ? 1 : 0,
      TodosFiled.details: details,
      TodosFiled.category: category,
      TodosFiled.toDoTime: toDoTime!.toIso8601String(),
      TodosFiled.remind: remind!.toIso8601String(),
      //TodosFiled.tableName: tableName,
    };
  }

  ToDo.fromMap(Map<String,dynamic> map)
  {
    id = map[TodosFiled.id];
    title = map[TodosFiled.title];
    details = map[TodosFiled.details];
    category = map[TodosFiled.category];
    toDoTime = DateTime.parse(map[TodosFiled.toDoTime] as String);
    remind =  DateTime.parse(map[TodosFiled.remind] as String);
    isDone = map[TodosFiled.isDone] == 1;
    //tableName =  map[TodosFiled.tableName];
  }

}
