import 'package:eisenhower_matrix/config/constants.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/category.dart';
import 'package:eisenhower_matrix/model/db/database_model.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/sub_todo.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/user.dart';
import 'package:eisenhower_matrix/model/note_app/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/utils/utils.dart' as utils;

class MyDatabase{

  MyDatabase._();

  static final localDatabase = MyDatabase._();

   Future<Database> dogDatabase()async
   {
     return openDatabase(
       join(await getDatabasesPath() , 'dogs_db.db'),
       onCreate: (db,version){
         return db.execute(
             'CREATE TABLE dogs (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
       },
       version: 1,
     );
   }

   Future<Database> catDatabase()async
   {
     return openDatabase(
       join(await getDatabasesPath() , 'cats_db.db'),
         onCreate: (db,version){
           return db.execute(
               'CREATE TABLE cats (id INTEGER PRIMARY KEY, name TEXT)');
         },
       version: 1,
     );
   }

   Future<Database> todosDatabase()async
   {

     return openDatabase(
       join(await getDatabasesPath(),'todos_db.db'),
       onCreate: (db,version) async {

         await db.execute('''
          CREATE TABLE $toDosUrgentAndImportantTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ${TodosFiled.isDone} $boolType,
            ${TodosFiled.title} $textType,
            ${TodosFiled.category} $textType,
            ${TodosFiled.details} $textType,
            ${TodosFiled.toDoTime} $textType,
            ${TodosFiled.remind} $textType
          )
        ''');

         await db.execute('''
          CREATE TABLE $toDosUrgentAndUnimportantTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ${TodosFiled.isDone} $boolType,
            ${TodosFiled.title} $textType,
            ${TodosFiled.category} $textType,
            ${TodosFiled.details} $textType,
            ${TodosFiled.toDoTime} $textType,
            ${TodosFiled.remind} $textType
          )
        ''');

         await db.execute('''
          CREATE TABLE $toDosNotUrgentAndImportantTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ${TodosFiled.isDone} $boolType,
            ${TodosFiled.title} $textType,
            ${TodosFiled.category} $textType,
            ${TodosFiled.details} $textType,
            ${TodosFiled.toDoTime} $textType,
            ${TodosFiled.remind} $textType
          )
        ''');

         await db.execute('''
          CREATE TABLE $toDosNotUrgentNotImportantTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ${TodosFiled.isDone} $boolType,
            ${TodosFiled.title} $textType,
            ${TodosFiled.category} $textType,
            ${TodosFiled.details} $textType,
            ${TodosFiled.toDoTime} $textType,
            ${TodosFiled.remind} $textType
          )
        ''');

         await db.execute('''
          CREATE TABLE SubTodos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ${TodosFiled.isDone} $boolType,
            ${TodosFiled.title} $textType,
            ${TodosFiled.category} $textType,
            ${TodosFiled.details} $textType,
            ${TodosFiled.toDoTime} $textType,
            ${TodosFiled.remind} $textType,
            parentToDoName $textType
          )
        ''');

         await db.execute('''
          CREATE TABLE $toDayToDosDayTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ${TodosFiled.isDone} $boolType,
            ${TodosFiled.title} $textType,
            ${TodosFiled.category} $textType,
            ${TodosFiled.details} $textType,
            ${TodosFiled.toDoTime} $textType,
            ${TodosFiled.remind} $textType
          )
        ''');

         await db.execute('''
          CREATE TABLE $tableCategories(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ${CategoriesFiled.content} $textType
          )
        ''');
         await db.execute('''
        CREATE TABLE $tableNotes(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         ${NoteFields.isImportant} $boolType,
         ${NoteFields.number} $integerType,
         ${NoteFields.title} $textType,
         ${NoteFields.description} $textType,
         ${NoteFields.time} $textType
         )
       ''');
      },

       version: 1,
     );
   }

   Future<Database> getDatabase(DatabaseModel model)async
   {
     return await getDatabaseByName(model.database().toString());
   }

   Future<Database> getDatabaseByName(String dbName) async
   {
     switch (dbName){
       case 'dogs_db':
         return await dogDatabase();
       case 'cats_db':
         return await catDatabase();
       case 'todos_db':
         return await todosDatabase();
       default :
         return await todosDatabase();
     }
   }

   Future<void> insert(DatabaseModel model)async
   {
     final Database db = await getDatabase(model);
     await db.insert(model.table().toString(), model.toMap() as Map<String,dynamic>,conflictAlgorithm: ConflictAlgorithm.replace);
     db.close();
   }

   Future<void> update(DatabaseModel model)async
   {
     final Database db = await getDatabase(model);
     await db.update(model.table().toString(), model.toMap() as Map<String,dynamic>,where: 'id= ?',whereArgs: [model.getId()] );
     db.close();
   }

   Future<void> delete(DatabaseModel model)async
   {
     final Database db = await getDatabase(model);
     await db.delete(model.table().toString(),where: 'id= ?',whereArgs: [model.getId()] );
     db.close();
   }

   Future<List<DatabaseModel>> getAll(String table,String dbName)async
   {
     final Database db = await getDatabaseByName(dbName);
     final List<Map<String,dynamic>> maps = await db.query(table,);
     List<DatabaseModel> models = [];
     for(var item in maps){
       switch(table){
         case toDosUrgentAndImportantTable:
           models.add(ToDo.fromMap(item));
           break;
         case toDosUrgentAndUnimportantTable:
           models.add(ToDo.fromMap(item));
           break;
         case toDosNotUrgentAndImportantTable:
           models.add(ToDo.fromMap(item));
           break;
         case toDosNotUrgentNotImportantTable:
           models.add(ToDo.fromMap(item));
           break;
         case toDayToDosDayTable:
           models.add(ToDo.fromMap(item));
           break;
         case 'SubTodos':
           models.add(SubToDo.fromMap(item));
           break;
         case 'notes':
           models.add(Note.fromMap(item));
           break;
         case 'categories':
           models.add(Category.fromMap(item));
           break;
       }
     }
     return models;
   }

}