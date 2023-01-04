import 'package:audioplayers/audioplayers.dart';
import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/category.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/sub_todo.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/services/local_notification_servies.dart';
import 'package:eisenhower_matrix/ui/pages/pomodoro_app/pomodoro_page.dart';
import 'package:eisenhower_matrix/ui/widgets/drop_down_list_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TodayTodoList extends StatefulWidget {
  const TodayTodoList({Key? key}) : super(key: key);
  @override
  State<TodayTodoList> createState() => _TodayTodoListState();
}

class _TodayTodoListState extends State<TodayTodoList> {

  DateTime alarmDataTime  = DateTime.now();
  final TextEditingController _todosTitles = TextEditingController();
  final TextEditingController _todosDetails = TextEditingController();
  final _timeListTextItemController = TextEditingController();
  List<Widget> subToDosWidgetsList = [];


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final audioPlayer = AudioPlayer();
    return
    Scaffold(
      backgroundColor: Colors.grey.shade300,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildAddTaskSheet(context,0,false),
      body: Column(
        children: [

          const SizedBox(height: 50, width: double.infinity,),

          Consumer<ToDosController>(builder:(context,date,_){
            return ListView.builder(
              itemCount: date.toDayToDosDate.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
              itemBuilder: (BuildContext context, int index)
              {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    width:double.infinity,
                    //height: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                          child: Row(
                            children: [
                              // delete
                              InkWell(
                                onTap: (){
                                  date.deleteToDo(date.toDayToDosDate[index], index, toDayToDosDayTable);
                                },
                                child: const Icon(Icons.delete,color: Colors.red,),
                              ),
                              const SizedBox(width: 25,),
                              //edit
                              InkWell(
                                onTap: ()
                                {
                                  _todosTitles.text = date.toDayToDosDate[index].title;
                                  _todosDetails.text = date.toDayToDosDate[index].details!;
                                  _showMyDialog(index,true);
                                },
                                child: const Icon(Icons.edit,color: Colors.teal,size: 24,),
                              ),
                              const SizedBox(width: 25,),
                              //Pomodoro
                              InkWell(
                                onTap: ()
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PomodoroPage()),);
                                },
                                child: SizedBox(height:32,width:32,child: Image.asset("assets/dashboard/pomodoro.png",),),
                              ),
                            ],
                          ),
                        ),
                        // toDayToDosDate[index].title  , Checkbox
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              //mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                   SizedBox(
                                     height :date.toDayToDosDate[index].title.length > 15 ? date.toDayToDosDate[index].title.length * 1.18  : 20,
                                     width: 150,
                                     child:Text(
                                       date.toDayToDosDate[index].title,
                                       textAlign: TextAlign.end,
                                       softWrap: true,
                                       maxLines: 4,
                                       style:TextStyle(
                                         overflow: TextOverflow.ellipsis,
                                         fontFamily: "Almarai",
                                         fontSize: 17,
                                         color: Colors.grey.shade600,
                                         decoration:date.toDayToDosDate[index].isDone ? TextDecoration.lineThrough : TextDecoration.none,
                                         fontWeight: FontWeight.w100,
                                       ),
                                     ),
                                   ),
                                   Text(
                                     textAlign :TextAlign.end,
                                     softWrap: true,
                                      date.toDayToDosDate[index].category.toString(),
                                      style:TextStyle(
                                        fontFamily: "Almarai",
                                        fontSize: 12,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.red.shade900,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ],
                                ),
                                Transform.scale(
                                  scale: 1,
                                  child: Checkbox(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    checkColor: Colors.white,
                                    value: date.toDayToDosDate[index].isDone,
                                    onChanged: (bool? value)async {
                                      date.toDayToDosDate[index].isDone
                                      ?
                                      audioPlayer.stop()
                                      :
                                      audioPlayer.play(AssetSource('success-1-6297.mp3'));

                                      //await audioPlayer.play('assets/sounds/done sound effect.mpeg');
                                      audioPlayer.resume();
                                      date.toDayToDosDate[index].tableName = toDayToDosDayTable;
                                      date.checkIsDone(tableName: toDayToDosDayTable, index: index, value: value!);//= value!;
                                      Future.delayed(const Duration(milliseconds: 250), () async {
                                        date.sortListByBool(toDayToDosDayTable);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),


                            date.toDayToDosDate[index].details!.isNotEmpty
                                ?
                            SizedBox(
                              //height: date.toDayToDosDate[index].details!.length * 1 / 1.5,
                              height: 25,
                              width: 200,
                              child: Padding(
                              padding: const EdgeInsets.only(right: 48.0,left: 0,bottom: 10),
                              child: Text(
                                softWrap: true,
                                maxLines: 3,
                                textAlign : TextAlign.end,
                                date.toDayToDosDate[index].details!,
                                style:TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: "Almarai",
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  decoration:date.toDayToDosDate[index].isDone ? TextDecoration.lineThrough : TextDecoration.none,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                            )
                                :
                            const SizedBox(),

                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }


  Future<void> _showMyDialog(int index,bool isEdit) async
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(child: addTaskForm(context,isEdit,index)),
        );
      },
    );
  }

  Widget buildAddTaskSheet(BuildContext context ,int index,bool isEdit)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueAccent,
            child: IconButton(
              alignment : Alignment.centerLeft,
              onPressed: ()
              {
                 _showMyDialog(index,isEdit);
              },
              icon: const Icon(Icons.add , color: Colors.white,size: 35,),),
          ),
        ],
      ),
    );
  }

  Widget addTaskForm(BuildContext context,bool isEdit,int index)
  {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.38,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // المهمة
          Consumer<ToDosController>(
            builder: (context,date,_){
              return TextField(
                controller:_todosTitles,
                textAlign:TextAlign.end,
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  fillColor: Colors.grey.shade50,
                  filled: true,
                  hintText: isEdit ?  date.toDayToDosDate[index].title  : "المهمة",
                  hintStyle: const TextStyle(fontSize: 18,fontFamily: "Almarai"),
                  focusColor: Colors.blue,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color:Colors.blue,
                      width: 1.5,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 15,),

          // التفاصيل
          Consumer<ToDosController>(
              builder: (context,date,_){
                return TextField(
                  controller: _todosDetails,
                  textAlign:TextAlign.end,
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    fillColor: Colors.grey.shade50,
                    filled: true,
                    hintText:isEdit ? date.toDayToDosDate[index].details  : "التفاصيل",
                    hintStyle: const TextStyle(fontSize: 18,fontFamily: "Almarai"),
                    focusColor: Colors.blue,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                    ),
                  ),
                );
              }
          ),
          const SizedBox(height: 20,),

          // قائمة الاصناف
          Consumer<ToDosController>(
            builder: (context,data,_){
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width:225,height: 50,child:

                  CategoriesListDropdownButton(list: data.getCategoriesContentFromModel(), dropdownValue: '',),

                  ),
                  const Icon(Icons.filter_alt_outlined,size: 35,color: Colors.blueAccent,),
                ],
              );
            },
          ),

          /*
                   // الوقت
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // الوقت
              Consumer<ToDosController>(
                builder: (context,value,_){
                  return  InkWell(
                    onTap: ()async
                    {
                      value.alarmController(value.data, context).whenComplete((){
                        setState(() {});
                      });
                    },
                    child:Text("${alarmDataTime.day}/"
                        "${alarmDataTime.month}/"
                        "${alarmDataTime.year}  -  "
                        "${alarmDataTime.hour} : "
                        "${alarmDataTime.minute}",
                      style:const TextStyle(color: Colors.grey,fontSize: 20),),
                  );
                },
              ),
              const SizedBox(width: 20,),
              const Icon(Icons.calendar_month,size: 35,color: Colors.blue,),
            ],
          ),
          */

          // تذكير
          const SizedBox(height: 20,),
          Consumer<ToDosController>(
              builder: (context,date,_)
              {
            return InkWell(
              onTap: ()
              {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled : true,
                    context: context,
                    shape:const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                        bottom: Radius.circular(15),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    builder: (builder){
                      return StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding:const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                  color: Colors.white,
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 100,height: 50,
                                              child: TextField(
                                                controller:_timeListTextItemController,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                autofocus: true,
                                                decoration: const InputDecoration(
                                                    hintText: "0",
                                                    helperStyle: TextStyle(fontSize: 16)
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,height: 50,
                                              child: DropdownButton<String>(
                                                isExpanded : true,
                                                value: date.timeList.first,
                                                dropdownColor: Colors.white,
                                                icon: const Icon(Icons.arrow_downward,color: Colors.green,size: 22,),
                                                elevation: 0,
                                                style: const TextStyle(color: Colors.grey,fontSize: 20,fontFamily: "Almarai"),
                                                alignment : AlignmentDirectional.center,
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.grey.shade50,
                                                ),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    date.getRemindTimeItem(value!);
                                                  });
                                                },
                                                items: date.todayToDoListTimeList.map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            const Text("تذكير قبل",style:TextStyle(fontSize: 16,color: Colors.black54,fontFamily: "Almarai"),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 23.0),
                                        child: TextButton(
                                            onPressed: () async {
                                              int amount = int.parse(_timeListTextItemController.text).toInt();
                                              date.remindTimeItemSubmit(timeItem: date.remindTimeItem, amount: amount, data:date.data).whenComplete((){
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text("ok",style: TextStyle(fontSize: 18,fontFamily: "Almarai",color: Colors.blueAccent),)),
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          );

                        },
                      );
                    }
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // التذكير
                  Text("تذكير",style:TextStyle(fontSize: 18,color: Colors.grey.shade500,fontFamily: "Almarai"),),
                  const SizedBox(width: 20,),
                  const Icon(Icons.alarm,size: 35,color: Colors.blueAccent,),
                ],
              ),
            );
          }
          ),

          //"اضف المهمة"
          const SizedBox(height: 5,),
          Consumer<ToDosController>(
              builder: (context, value, _)
              {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width*0.11,
                  vertical: MediaQuery.of(context).size.height*0.01),
              child: Row(
                children: [
                  InkWell(
                    onTap: ()async{
                      if(_todosTitles.text.isNotEmpty)
                      {
                        if(isEdit == true)
                          {
                            value.toDayToDosDate[index].title = _todosTitles.text;
                            value.toDayToDosDate[index].details = _todosDetails.text;
                            value.toDayToDosDate[index].category = value.category;
                            value.toDayToDosDate[index].toDoTime = alarmDataTime;
                            value.toDayToDosDate[index].toDoTime = alarmDataTime;
                            value.toDayToDosDate[index].remind = value.data;
                            value.toDayToDosDate[index].isDone = false;
                            value.toDayToDosDate[index].tableName = toDayToDosDayTable;
                            value.toDayToDosDate[index].subTodos = [];
                            value.updateToDo(value.toDayToDosDate[index]);
                          }
                          else
                          {
                              value.addToDo(
                                ToDo(
                                  title: _todosTitles.text,
                                  details:  _todosDetails.text,
                                  category: value.category,
                                  toDoTime: alarmDataTime,
                                  remind: value.data,
                                  isDone: false,
                                  tableName :toDayToDosDayTable,
                                  subTodos: [],
                                ),
                              );
                            }
                          setState(() {
                           _todosTitles.text = '';
                           _todosDetails.text = '';
                           Navigator.pop(context);
                        });
                      }
                    },
                    child: Text( isEdit ?  "تعديل المهمة"  :"اضف المهمة",style: const TextStyle(fontSize: 18,color:Colors.blueAccent,fontFamily: "Almarai",fontWeight: FontWeight.w900),),
                  ),
                ],
              ),
            );
          }
          ),
        ],
      ),
    );
  }

  heightSize(int textLength)
  {
    if(textLength > 14 || textLength< 30)
    {
      return 35;
    }
    else if(textLength > 30 || textLength< 60)
    {
      return 50;
    }
    else
    {
      return 20;
    }

  }

}
