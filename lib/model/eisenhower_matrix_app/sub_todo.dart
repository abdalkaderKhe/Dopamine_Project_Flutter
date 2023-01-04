import 'package:eisenhower_matrix/model/db/database_model.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';


class SubToDo implements DatabaseModel
{
  int? id;
  late String title;
  late String? details;
  late String? category;
  late bool isDone;
  late DateTime? toDoTime;
  late DateTime? remind;
  late String tableName;
  late String parentToDoName;

  SubToDo({
    required this.title,
    required this.details,
    required  this.category,
    required this.toDoTime,
    required this.remind,
    required this.isDone,
    required this.tableName,
    required this.parentToDoName,
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
    return "SubTodos";
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
      TodosFiled.parentToDoName : parentToDoName,
    };
  }

  SubToDo.fromMap(Map<String,dynamic> map)
  {
    id = map[TodosFiled.id];
    title = map[TodosFiled.title];
    details = map[TodosFiled.details];
    category = map[TodosFiled.category];
    toDoTime = DateTime.parse(map[TodosFiled.toDoTime] as String);
    remind =  DateTime.parse(map[TodosFiled.remind] as String);
    isDone = map[TodosFiled.isDone] == 1;
    parentToDoName = map[TodosFiled.parentToDoName];
  }

}