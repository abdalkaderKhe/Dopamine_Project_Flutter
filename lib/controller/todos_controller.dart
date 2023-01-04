import 'package:eisenhower_matrix/config/constants.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/category.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/sub_todo.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/services/local_notification_servies.dart';
import 'package:flutter/material.dart';

class ToDosController with ChangeNotifier
{

  List<ToDo> urgentAndImportantToDosDate = [];
  List<ToDo> urgentAndUnimportantToDosDate  = [];
  List<ToDo> notUrgentAndImportantToDosDate  = [];
  List<ToDo> notUrgentNotImportantToDosDate = [];

  List<ToDo> beforeDeletionUrgentAndImportantToDosDate = [];
  List<ToDo> beforeDeletionUrgentAndUnimportantToDosDate = [];
  List<ToDo> beforeDeletionNotUrgentAndImportantToDosDate = [];
  List<ToDo> beforeDeletionNotUrgentNotImportantToDosDate = [];

  DateTime data = DateTime.now();
  DateTime remindTimeData = DateTime.now();

  bool alarmActive = false;
  bool remindAlarmActive = false;

  LocalNotificationServices notificationsServices = LocalNotificationServices();
  List<String> timeList = <String>['ساعة','يوم', 'اسبوع','دقيقة',];
  List<String> todayToDoListTimeList = <String>['ساعة','دقيقة',];
  String remindTimeItem  = '';

  List<Category> categoriesDate = [];
  String category = 'بلا تصنيف';
  List<SubToDo> subToDosDate = [];
  List<ToDo> toDayToDosDate = [];

  init()
  {
    getDateFromCategoryTable();
    fetchDateFromAllTables();
    fetchDateFromToDayToDos();
    notificationsServices.initialiseNotifications(Colors.red);
    notificationsServices.initialiseRemindNotifications(Colors.red);
  }

  getRemindTimeItem(String remindTimeItem)
  {
    return this.remindTimeItem = remindTimeItem;
  }

  getCategory(String category)
  {
    return this.category = category;
  }

  List<Category> getCategoriesFromModel()
  {
    return categoriesDate;
  }

  Future<List<ToDo>>fetchDateFromToDayToDosTable()async
  {
    List<ToDo> toDayToDosDate = [];
    await MyDatabase.localDatabase.getAll(toDayToDosDayTable,dataBaseName).then((value){
      toDayToDosDate.addAll(value.cast());
    });
    return toDayToDosDate;
  }

  Future<void> fetchDateFromToDayToDos()async
  {
    toDayToDosDate = await fetchDateFromToDayToDosTable();
    for (var element in toDayToDosDate) {
      element.tableName = toDayToDosDayTable;
    }
    notifyListeners();
  }


  List<ToDo> getToDosFromModel(String tableName)
  {
    //fetchDateFromTable(tableName: tableName);
    if(tableName == toDosUrgentAndImportantTable)
    {
      return urgentAndImportantToDosDate;
    }
    else if(tableName == toDosNotUrgentAndImportantTable)
    {
      return urgentAndUnimportantToDosDate;
    }
    else if(tableName == toDosUrgentAndUnimportantTable)
    {
      return notUrgentAndImportantToDosDate;
    }
    else if(tableName == toDayToDosDayTable)
    {
      return toDayToDosDate;
    }
    else
    {
      return notUrgentNotImportantToDosDate;
    }

  }

  //alarm
  Future<void> alarmController(DateTime data , BuildContext context)async
  {
    DateTime? timeData = await showDatePicker(
      context: context,
      initialDate: data,
      firstDate: DateTime(200),
      lastDate: DateTime(2100),
    );

    if(timeData == null) return;

    TimeOfDay? dayTimeData = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: data.hour,
        minute: data.minute,
      ),
    );

    if(dayTimeData == null) return;

    final newTimeData = DateTime(timeData.year,timeData.month,timeData.day,dayTimeData.hour,dayTimeData.minute);

    this.data = newTimeData;

    alarmActive = true;

    notifyListeners();

  }

  Future<void> remindTimeItemSubmit({required String timeItem,required int amount , required DateTime data})async
  {
    if(timeItem == "ساعة")
    {
      await notificationsServices.Notify(
        title: "",
        body: "عاجل ومهم",
        year: data.year.toInt(),
        month: data.month.toInt(),
        day: data.day.toInt(),
        hour: (data.hour.toInt()) - amount,
        minute: data.minute.toInt(),
      );
    }
    if(timeItem == "يوم")
    {
      await notificationsServices.Notify(
        title: "",
        body: "عاجل ومهم",
        year: data.year.toInt(),
        month: data.month.toInt(),
        day: (data.day.toInt()) - amount,
        hour: data.hour.toInt(),
        minute: data.minute.toInt(),
      );
    }
    if(timeItem == "اسبوع")
    {
      await notificationsServices.Notify(
        title:"",
        body: "عاجل ومهم",
        year: data.year.toInt(),
        month: data.month.toInt(),
        day: ((data.day.toInt()) - 7) * amount,
        hour: data.hour.toInt(),
        minute: data.minute.toInt(),
      );
    }
    if(timeItem == 'دقيقة')
    {
      await notificationsServices.NotifyRemindTime(
        title: "",
        body: "عاجل ومهم",
        year: data.year.toInt(),
        month: (data.month.toInt()),
        day: data.day.toInt(),
        hour: data.hour.toInt(),
        minute: (data.minute.toInt()) - amount,
      );
    }
  }

  List<String> getCategoriesContentFromModel()
  {
    List<String> contents = [];
    for(int i = 0 ;i<categoriesDate.length ; i++)
    {
      contents.add(categoriesDate[i].content.toString());
    }
    return contents;
  }

  Future<void> getDateFromCategoryTable()async
  {
    categoriesDate = await fetchDateFromCategoryTable();
    notifyListeners();
  }

  Future<List<Category>> fetchDateFromCategoryTable()async
  {
    List<Category> todosTable = [];
    await MyDatabase.localDatabase.getAll("categories", dataBaseName).then((value){
      todosTable.addAll(value.cast());
    });
    return todosTable;
  }

  // CRUD
  void updateToDo(ToDo toDo)
  {
    MyDatabase.localDatabase.update(toDo);
    // ToDo
    fetchDateFromAllTables();
    if(alarmActive)
    {
      notificationsServices.Notify(
        title: 'title', body: 'body',
        year: data.year.toInt(), month: data.month.toInt(),
        day: data.day.toInt(), hour: data.hour.toInt(),
        minute: data.minute.toInt(),
      );
    }
  }

  void updateToDoToTodosModel({required String tableName,required ToDo toDo})
  {
    switch(tableName){
    //عاجل و مهم
      case toDosUrgentAndImportantTable:
        urgentAndImportantToDosDate.add(toDo);
        break;

      case toDosNotUrgentAndImportantTable:
        urgentAndUnimportantToDosDate.add(toDo);
        break;

      case toDosUrgentAndUnimportantTable:
        notUrgentAndImportantToDosDate.add(toDo);
        break;

      case toDosNotUrgentNotImportantTable:
        notUrgentNotImportantToDosDate.add(toDo);
        break;
    }
    notifyListeners();
  }

  void addToDo(ToDo toDo)
  {
    MyDatabase.localDatabase.insert(toDo);
    addToDoToTodosModel(tableName:toDo.tableName,toDo:toDo);
    // ToDo
    fetchDateFromAllTables();
    if(alarmActive)
    {
        notificationsServices.Notify(
            title: 'title', body: 'body',
            year: data.year.toInt(), month: data.month.toInt(),
            day: data.day.toInt(), hour: data.hour.toInt(),
            minute: data.minute.toInt(),
        );
      }
  }

  void addCategory(Category category)
  {
    MyDatabase.localDatabase.insert(category);
    categoriesDate.add(category);
    notifyListeners();
  }

  void deleteCategory(Category category)
  {
    MyDatabase.localDatabase.delete(category);
    categoriesDate.remove(category);
    notifyListeners();
  }

  void addSubToDo(SubToDo subToDo)async
  {
    MyDatabase.localDatabase.insert(subToDo);
    subToDosDate.add(subToDo);
    notifyListeners();
    if(alarmActive)
    {
      notificationsServices.Notify(
        title: 'title', body: 'body',
        year: data.year.toInt(), month: data.month.toInt(),
        day: data.day.toInt(), hour: data.hour.toInt(),
        minute: data.minute.toInt(),
      );
    }
  }

  void deleteToDo(ToDo toDo , int index , String tableName)
  {
    toDo.tableName = tableName;
    MyDatabase.localDatabase.delete(toDo);
    deleteToDoToTodosModel(tableName:toDo.tableName,index:index);
  }

  void deleteSubToDo(SubToDo subToDo)
  {
    MyDatabase.localDatabase.delete(subToDo);
    notifyListeners();
  }

  void deleteToDoToTodosModel({required String tableName,required int index})
  {
    switch(tableName){
    //عاجل و مهم
      case toDosUrgentAndImportantTable:
        urgentAndImportantToDosDate.removeAt(index);
        break;

      case toDosNotUrgentAndImportantTable:
        urgentAndUnimportantToDosDate.removeAt(index);
        break;

      case toDosUrgentAndUnimportantTable:
        notUrgentAndImportantToDosDate.removeAt(index);
        break;

      case toDosNotUrgentNotImportantTable:
        notUrgentNotImportantToDosDate.removeAt(index);
        break;

      case toDayToDosDayTable:
        toDayToDosDate.removeAt(index);
        break;
    }
    notifyListeners();
  }

  //
  void checkIsDone({required String tableName,required int index , required bool value})
  {
    MyDatabase.localDatabase.update(getToDosFromModel(tableName)[index]);
    getToDosFromModel(tableName)[index].isDone = value;
    for(int i =0 ; i<getToDosFromModel(tableName)[index].subTodos.length;i++)
    {
      getToDosFromModel(tableName)[index].subTodos[i].isDone = value;
    }
    //sortListByBool(tableName);
    notifyListeners();
  }

  sortListByBool(String tableName)
  {
    getToDosFromModel(tableName).sort((a, b) => a.isDone.toString().compareTo(b.isDone.toString()),);
    notifyListeners();
  }

  void addToDoToTodosModel({required String tableName,required ToDo toDo})
  {
    switch(tableName){
      //عاجل و مهم
      case toDosUrgentAndImportantTable:
        urgentAndImportantToDosDate.add(toDo);
        break;

      case toDosNotUrgentAndImportantTable:
        urgentAndUnimportantToDosDate.add(toDo);
        break;

      case toDosUrgentAndUnimportantTable:
        notUrgentAndImportantToDosDate.add(toDo);
        break;

      case toDosNotUrgentNotImportantTable:
        notUrgentNotImportantToDosDate.add(toDo);
        break;
      case toDayToDosDayTable:
        toDayToDosDate.add(toDo);
        break;
    }
    notifyListeners();
  }

  Future<List<ToDo>> fetchDateFromTable({required String tableName})async
  {
    List<ToDo> todosTable = [];
    List<SubToDo> subToDosDate = [];
    await MyDatabase.localDatabase.getAll(tableName, dataBaseName).then((value){
      todosTable.addAll(value.cast());
    }).whenComplete(()
    {
      MyDatabase.localDatabase.getAll("SubTodos", dataBaseName).then((value){
        subToDosDate.addAll(value.cast());
      }).whenComplete((){
        for(int i = 0 ; i<subToDosDate.length ; i++)
        {
          for(int j = 0 ; j<todosTable.length ; j++)
          {
            if(subToDosDate[i].parentToDoName == todosTable[j].title)
            {
              todosTable[j].subTodos.add(subToDosDate[i]);
            }
          }
        }
      });
    });
    return todosTable;
  }

  Future<void> fetchDateFromAllTables()async
  {
    // عاجل ومهم
    urgentAndImportantToDosDate = await fetchDateFromTable(tableName: toDosUrgentAndImportantTable,);
    beforeDeletionUrgentAndImportantToDosDate = await fetchDateFromTable(tableName: toDosUrgentAndImportantTable,);

    // غير مهم وغير عاجل
    notUrgentNotImportantToDosDate = await fetchDateFromTable(tableName: toDosNotUrgentNotImportantTable,);
    beforeDeletionNotUrgentNotImportantToDosDate = await fetchDateFromTable(tableName: toDosNotUrgentNotImportantTable,);

    // غير عاجل  و مهمnotUrgentAndImportantToDosDate
    urgentAndUnimportantToDosDate = await fetchDateFromTable(tableName: toDosNotUrgentAndImportantTable,);
    beforeDeletionNotUrgentAndImportantToDosDate = await fetchDateFromTable(tableName: toDosNotUrgentAndImportantTable,);

    // عاجل وغير مهم
    notUrgentAndImportantToDosDate = await fetchDateFromTable(tableName: toDosUrgentAndUnimportantTable,);
    beforeDeletionUrgentAndUnimportantToDosDate = await fetchDateFromTable(tableName: toDosUrgentAndUnimportantTable,);

    toDayToDosDate = await fetchDateFromToDayToDosTable();

    notifyListeners();

  }


  // options
  Future<void> deleteDoneTasks()async
  {
    for(int i=0;i<urgentAndImportantToDosDate.length;i++)
    {
      urgentAndImportantToDosDate[i].tableName = toDosUrgentAndImportantTable;
      if(urgentAndImportantToDosDate[i].isDone == true)
      {
        MyDatabase.localDatabase.delete(urgentAndImportantToDosDate[i]);
        urgentAndImportantToDosDate.removeAt(i);
      }
    }
    for(int i=0;i<urgentAndUnimportantToDosDate.length;i++)
    {
      urgentAndUnimportantToDosDate[i].tableName = toDosNotUrgentAndImportantTable;
      if(urgentAndUnimportantToDosDate[i].isDone == true)
      {
        MyDatabase.localDatabase.delete(urgentAndUnimportantToDosDate[i]);
        urgentAndUnimportantToDosDate.removeAt(i);
      }
    }
    for(int i=0;i<notUrgentAndImportantToDosDate.length;i++)
    {
      notUrgentAndImportantToDosDate[i].tableName = toDosUrgentAndUnimportantTable;
      if(notUrgentAndImportantToDosDate[i].isDone == true)
      {
        MyDatabase.localDatabase.delete(notUrgentAndImportantToDosDate[i]);
        notUrgentAndImportantToDosDate.removeAt(i);
      }
    }
    for(int i=0;i<notUrgentNotImportantToDosDate.length;i++)
    {
      notUrgentNotImportantToDosDate[i].tableName = toDosNotUrgentNotImportantTable;
      if(notUrgentNotImportantToDosDate[i].isDone == true)
      {
        MyDatabase.localDatabase.delete(notUrgentNotImportantToDosDate[i]);
        notUrgentNotImportantToDosDate.removeAt(i);
      }
    }
    notifyListeners();
  }

  Future<void> deleteAllTasks()async
  {
    for(int i=0;i<urgentAndImportantToDosDate.length;i++)
    {
      urgentAndImportantToDosDate[i].tableName = toDosUrgentAndImportantTable;
      deleteToDo(urgentAndImportantToDosDate[i], i, urgentAndImportantToDosDate[i].tableName);
    }
    for(int i=0;i<urgentAndUnimportantToDosDate.length;i++)
    {
      urgentAndImportantToDosDate[i].tableName = toDosNotUrgentAndImportantTable;
      deleteToDo(urgentAndUnimportantToDosDate[i], i, urgentAndUnimportantToDosDate[i].tableName);
    }
    for(int i=0;i<notUrgentAndImportantToDosDate.length;i++)
    {
      urgentAndImportantToDosDate[i].tableName = toDosUrgentAndUnimportantTable;
      deleteToDo(notUrgentAndImportantToDosDate[i], i, notUrgentAndImportantToDosDate[i].tableName);
    }
    for(int i=0;i<notUrgentNotImportantToDosDate.length;i++)
    {
      urgentAndImportantToDosDate[i].tableName = toDosNotUrgentNotImportantTable;
      deleteToDo(notUrgentNotImportantToDosDate[i], i, notUrgentNotImportantToDosDate[i].tableName);
    }
    notifyListeners();
  }

  Future<void> sortByFurthest()async
  {
    // عاجل وغير مهم
    //urgentAndUnimportantToDosDate.sort((a, b) => b.toDoTime!.day.compareTo(a.toDoTime!.day));
    urgentAndUnimportantToDosDate.sort((a, b){ //sorting in ascending order
      return DateTime.parse(b.toDoTime.toString()).compareTo(DateTime.parse(a.toDoTime.toString()));
    });

    // غير عاجل  و مهم
    //notUrgentAndImportantToDosDate.sort((a, b) => b.toDoTime!.day.compareTo(a.toDoTime!.day));
    urgentAndUnimportantToDosDate.sort((a, b){ //sorting in ascending order
      return DateTime.parse(b.toDoTime.toString()).compareTo(DateTime.parse(a.toDoTime.toString()));
    });

    // غير مهم وغير عاجل
    //notUrgentNotImportantToDosDate.sort((a, b) => b.toDoTime!.day.compareTo(a.toDoTime!.day));
    urgentAndUnimportantToDosDate.sort((a, b){ //sorting in ascending order
      return DateTime.parse(b.toDoTime.toString()).compareTo(DateTime.parse(a.toDoTime.toString()));
    });

    // عاجل ومهم
    //urgentAndImportantToDosDate.sort((a, b) => b.toDoTime!.day.compareTo(a.toDoTime!.day));
    urgentAndUnimportantToDosDate.sort((a, b){ //sorting in ascending order
      return DateTime.parse(b.toDoTime.toString()).compareTo(DateTime.parse(a.toDoTime.toString()));
    });

    notifyListeners();
  }

  Future<void> sortByClosest()async
  {
    // عاجل وغير مهم
    // urgentAndUnimportantToDosDate.sort((a, b) => a.toDoTime!.hour.compareTo(b.toDoTime!.hour));
    urgentAndUnimportantToDosDate.sort((a, b){ //sorting in ascending order
      return DateTime.parse(a.toDoTime.toString()).compareTo(DateTime.parse(b.toDoTime.toString()));
    });

    // غير عاجل  و مهم
    //notUrgentAndImportantToDosDate.sort((a, b) => a.toDoTime!.second.compareTo(b.toDoTime!.second));
    urgentAndUnimportantToDosDate.sort((a, b){ //sorting in ascending order
      return DateTime.parse(a.toDoTime.toString()).compareTo(DateTime.parse(b.toDoTime.toString()));
    });

    // غير مهم وغير عاجل
    //notUrgentNotImportantToDosDate.sort((a, b) => a.toDoTime!.hour.compareTo(b.toDoTime!.hour));
    notUrgentNotImportantToDosDate.sort((a, b){ //sorting in ascending order
      return DateTime.parse(a.toDoTime.toString()).compareTo(DateTime.parse(b.toDoTime.toString()));
    });


    // عاجل ومهم
    //urgentAndImportantToDosDate.sort((a, b) => a.toDoTime!.hour.compareTo(b.toDoTime!.hour));
    urgentAndImportantToDosDate.sort((a, b){ //sorting in ascending order
      return DateTime.parse(a.toDoTime.toString()).compareTo(DateTime.parse(b.toDoTime.toString()));
    });


    notifyListeners();
  }

  Future<void> filterByCategory(String category , bool isChecked)async
  {

    if(isChecked)
    {
      for (int i = 0; i < urgentAndImportantToDosDate.length; i++)
      {
        if (urgentAndImportantToDosDate[i].category == category)
        {
          urgentAndImportantToDosDate.removeAt(i);
        }
      }

      for (int i = 0; i < urgentAndUnimportantToDosDate.length; i++)
      {
        if (urgentAndUnimportantToDosDate[i].category == category)
        {
          urgentAndUnimportantToDosDate.removeAt(i);
        }
      }

      for (int i = 0; i < notUrgentAndImportantToDosDate.length; i++)
      {
        if (notUrgentAndImportantToDosDate[i].category == category)
        {
          notUrgentAndImportantToDosDate.removeAt(i);
        }
      }

      for (int i = 0; i < notUrgentNotImportantToDosDate.length; i++)
      {
        if (notUrgentNotImportantToDosDate[i].category == category) {
          notUrgentNotImportantToDosDate.removeAt(i);
        }
      }
    }

    if(isChecked == false)
    {
      for (int i = 0; i < beforeDeletionUrgentAndImportantToDosDate.length; i++)
      {
        if (beforeDeletionUrgentAndImportantToDosDate[i].category == category)
        {
          urgentAndImportantToDosDate.add(beforeDeletionUrgentAndImportantToDosDate[i]);
        }
      }

      for (int i = 0; i < beforeDeletionUrgentAndUnimportantToDosDate.length; i++)
      {
        if (beforeDeletionUrgentAndUnimportantToDosDate[i].category == category)
        {
          urgentAndUnimportantToDosDate.add(beforeDeletionUrgentAndUnimportantToDosDate[i]);
        }
      }

      for (int i = 0; i < beforeDeletionNotUrgentAndImportantToDosDate.length; i++)
      {
        if (beforeDeletionNotUrgentAndImportantToDosDate[i].category == category)
        {
          notUrgentAndImportantToDosDate.add(beforeDeletionNotUrgentAndImportantToDosDate[i]);
        }
      }

      for (int i = 0; i < beforeDeletionNotUrgentNotImportantToDosDate.length; i++)
      {
        if (beforeDeletionNotUrgentNotImportantToDosDate[i].category == category)
        {
          notUrgentNotImportantToDosDate.add(beforeDeletionNotUrgentNotImportantToDosDate[i]);
        }
      }

    }

    notifyListeners();

  }

}