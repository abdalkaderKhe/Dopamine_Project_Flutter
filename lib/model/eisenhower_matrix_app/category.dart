import 'package:eisenhower_matrix/model/db/database_model.dart';

final String tableCategories = 'categories';

class CategoriesFiled{
  static final String id = 'id';
  static final String content = 'content';
}

class Category implements DatabaseModel{

  int? id;
  String? content;

  Category(this.content);

  Category.fromMap(Map<String,dynamic> map)
  {
    id = map[CategoriesFiled.id];
    content = map[CategoriesFiled.content];
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
    return "categories";
  }

  @override
  Map<String, dynamic>? toMap() {
    return {
      CategoriesFiled.id: id,
      CategoriesFiled.content: content,
    };
  }
}