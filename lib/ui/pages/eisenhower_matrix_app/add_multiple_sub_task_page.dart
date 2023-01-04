import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/sub_todo.dart';
import 'package:flutter/material.dart';
import 'package:eisenhower_matrix/model/db/database_model.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/category.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/services/local_notification_servies.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/add_multiple_task_page.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/todos_page.dart';
import 'package:eisenhower_matrix/ui/widgets/drop_down_list_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_multiple_sub_task_page.dart';
class AddMultipleSubTaskPage extends StatefulWidget {
  Color color;
  String tableName;
  String parentToDoName;
  AddMultipleSubTaskPage({Key? key,required this.color, required this.tableName,required this.parentToDoName}) : super(key: key);
  @override
  State<AddMultipleSubTaskPage> createState() => _AddMultipleSubTaskPageState();
}

class _AddMultipleSubTaskPageState extends State<AddMultipleSubTaskPage> {
  List<DateTime> alarmDataTimeList  = [DateTime.now(),];
  final List<TextEditingController> _todosTitles = [TextEditingController(),];
  final List<TextEditingController> _todosDetails = [TextEditingController(),];
  final _timeListTextItemController = TextEditingController();
  List<Widget> subToDosWidgetsList = [];
  int indexer = 0 ;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: buildAddSubTaskSheet(context,indexer),
      body:// isLoading ? const Center(child: CircularProgressIndicator(color: Colors.grey,),) :
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              Center(child: Text(" المهام الضمنية للمهمة ${widget.parentToDoName}",style:const TextStyle(fontSize: 24,fontFamily: "Almarai",color: Colors.grey),)),
              const SizedBox(height: 10,),
              ListView.builder(
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
                 physics:const ScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: subToDosWidgetsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return addTaskForm(context,index);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addTaskForm(BuildContext context,int index)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20,),
        // المهمة
        TextField(
          controller: _todosTitles[index],
          textAlign:TextAlign.end,
          autofocus: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            fillColor: Colors.grey.shade50,
            filled: true,
            hintText: "المهمة",
            hintStyle: const TextStyle(fontSize: 18,fontFamily: "Almarai"),
            focusColor: widget.color,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.color,
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),

        // التفاصيل
        TextField(
          controller: _todosDetails[index],
          textAlign:TextAlign.end,
          autofocus: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            fillColor: Colors.grey.shade50,
            filled: true,
            hintText: "التفاصيل",
            hintStyle: const TextStyle(fontSize: 18,fontFamily: "Almarai"),
            focusColor: widget.color,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.color,
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),

        // قائمة الاصناف
        Consumer<ToDosController>(
          builder:(context,value,_){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //categoriesListDropdownButton,
                CategoriesListDropdownButton(list: value.getCategoriesContentFromModel(), dropdownValue: '',),
                Icon(Icons.filter_alt_outlined,size: 35,color: widget.color,),
              ],
            );
          }
        ),

        // الوقت
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // الوقت
            Consumer<ToDosController>
              (builder:(context,value,_)
              {
                return InkWell(
                onTap: ()async
                {
                  value.alarmController(value.data, context).whenComplete((){
                    alarmDataTimeList.insert(index, value.data);
                    setState(() {});
                  });
                },
                child:Text("${alarmDataTimeList[index].day}/"
                    "${alarmDataTimeList[index].month}/"
                    "${alarmDataTimeList[index].year}  -  "
                    "${alarmDataTimeList[index].hour} : "
                    "${alarmDataTimeList[index].minute}",
                  style:const TextStyle(color: Colors.grey,fontSize: 20),),
              );
              },
            ),
            const SizedBox(width: 20,),
            Icon(Icons.calendar_month,size: 35,color: widget.color,),
          ],
        ),

        // تذكير
        const SizedBox(height: 10,),
        Consumer<ToDosController>(builder: (context,date,_){
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
                                              items: date.timeList.map<DropdownMenuItem<String>>((String value) {
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
                                          child: Text("ok",style: TextStyle(fontSize: 18,fontFamily: "Almarai",color: widget.color),)),
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
                Icon(Icons.alarm,size: 35,color: widget.color,),
              ],
            ),
          );
        }),

        //"اضف المهمة"
        const SizedBox(height: 4,),
        Consumer<ToDosController>(
          builder: (context,value,_){
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width*0.30,
                  vertical: MediaQuery.of(context).size.height*0.01),
              child: Row(
                children: [
                  InkWell(
                    onTap: ()async{
                      if(_todosTitles[index].text.isNotEmpty)
                      {
                        value.addSubToDo(
                          SubToDo(
                          title: _todosTitles[index].text,
                          details:  _todosDetails[index].text,
                          category: value.category,
                          toDoTime: alarmDataTimeList[index],
                          remind: value.data,
                          isDone: false,
                          tableName :widget.tableName,
                          parentToDoName: widget.parentToDoName,
                         ),
                        );
                         setState(() {
                           subToDosWidgetsList.removeAt(index);
                           if(index == 0)
                             {
                               Navigator.pop(context);
                             }
                         });
                      }
                    },
                    child: Text("اضف المهمة",style: TextStyle(fontSize: 18,color: widget.color,fontFamily: "Almarai",fontWeight: FontWeight.w900),),
                  ),
                ],
              ),
            );
          },
        ),

        const Divider(height: 1, color: Colors.grey,),
      ],
    );
  }

  Widget buildAddSubTaskSheet(BuildContext context , int index)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Consumer<ToDosController>(builder: (context,value,_){
          return CircleAvatar(
            radius: 30,
            backgroundColor: widget.color,
            child: IconButton(
              alignment : Alignment.centerLeft,
              onPressed: ()
              {
                setState(() {
                    subToDosWidgetsList.add(addTaskForm(context,index));
                    alarmDataTimeList.add(DateTime.now(),);
                   _todosTitles.add(TextEditingController());
                   _todosDetails.add(TextEditingController());
                    indexer = subToDosWidgetsList.length;
                 // setState(() {
                 //   indexer = subToDosWidgetsList.length;
                //  });
                });
              },
              icon: const Icon(Icons.add, color: Colors.white,size: 35,),),
          );
        })
      ],
    );
  }

}
