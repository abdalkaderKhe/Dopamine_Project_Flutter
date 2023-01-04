import 'package:eisenhower_matrix/model/db/database_model.dart';

class User
{
  final int id;
  final String name;
  final int age;

  User(this.id, this.name,this.age);
}

class Dod implements DatabaseModel{
   late int dogId;
   late String dogName;
   late int dogAge;

  Dod(this.dogId, this.dogName,this.dogAge);

  Dod.fromMap(Map<String,dynamic> map)
  {
    dogId = map['id'];
    dogName = map['name'];
    dogAge = map['age'];
  }

  @override
  String? table() {
    return 'dogs';
  }

  @override
  Map<String, dynamic>? toMap()
  {
    return {
      'id' : dogId,
      'name' : dogName,
      'age' : dogAge,
    };
  }

  @override
  String? database()
  {
    return "dogs_db";
  }

  @override
  int? getId()
  {
    return this.dogId;
  }

}

class Cat implements DatabaseModel
{

  late int id;
  late String name;

  Cat(this.id,this.name);

  Cat.fromMap(Map<String,dynamic> map){
    id = map['id'];
    name = map['name'];
  }

  @override
  String? table() {
    return 'cats';
  }

  @override
  Map<String, dynamic>? toMap() {
   return {
     'id' : id,
     'name' : name,
   };
  }

  @override
  String? database() {
    return "cats_db";
  }

  @override
  int? getId() {
    return this.id;
  }

}