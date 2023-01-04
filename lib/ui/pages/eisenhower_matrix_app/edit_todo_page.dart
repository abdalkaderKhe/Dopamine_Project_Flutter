import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/category.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/services/local_notification_servies.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/todos_page.dart';
import 'package:eisenhower_matrix/ui/pages/pomodoro_app/pomodoro_page.dart';
import 'package:eisenhower_matrix/ui/widgets/check_box_widget.dart';
import 'package:eisenhower_matrix/ui/widgets/drop_down_list_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class EditTodoPage extends StatefulWidget {
  Color color;
  String tableName;
  ToDo todo;
  EditTodoPage({Key? key,required this.color, required this.tableName,required this.todo}) : super(key: key);
  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {


  final _formKey = GlobalKey<FormState>();

  DateTime data = DateTime.now();
  DateTime remindTimeData = DateTime.now();

  final TextEditingController _todoTitle = TextEditingController();
  final TextEditingController _todoDetails = TextEditingController();

  final _timeListTextItemController = TextEditingController();

  @override
  void initState() {
    _todoTitle.text = widget.todo.title;
    _todoDetails.text = widget.todo.details!;
     data = widget.todo.toDoTime!;
     remindTimeData = widget.todo.remind!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("تعديل المهمة",style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w900),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:// isLoading ? const Center(child: CircularProgressIndicator(color: Colors.grey,),) :
      SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                // المهمة
                TextField(
                  controller: _todoTitle,
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
                const SizedBox(height: 25,),

                // التفاصيل
                TextField(
                  controller: _todoDetails,
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
                const SizedBox(height: 40,),

                // قائمة الاصناف
                Consumer<ToDosController>(
                  builder: (context,data,_){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoriesListDropdownButton(list: data.getCategoriesContentFromModel(), dropdownValue: '',),
                        Icon(Icons.filter_alt_outlined,size: 35,color: widget.color,),
                      ],
                    );
                  },
                ),

                // الوقت
                const SizedBox(height: 40,),
                Consumer<ToDosController>(
                  builder: (context,value,_){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // الوقت
                        InkWell(
                          onTap: ()async
                          {
                            value.alarmController(data, context);
                          },
                          child:Text("${data.day}/${data.month}/${data.year}  -  ${data.hour} : ${data.minute}",style:const TextStyle(color: Colors.grey,fontSize: 20),),
                        ),

                        const SizedBox(width: 20,),
                        Icon(Icons.calendar_month,size: 35,color: widget.color,),
                      ],
                    );
                  },
                ),

                // تذكير
                const SizedBox(height: 25,),
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

                const SizedBox(height: 25,),
                const Center(child: Text("المهام الضمنية",style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w400),)),

                widget.todo.subTodos.isNotEmpty ?
                Column(
                  children: widget.todo.subTodos.map((subTodo) =>
                      Column(
                        children: [
                          const SizedBox(height: 8,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[

                              Row(
                                children: [
                                  const SizedBox(width: 4,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: InkWell(
                                      onTap: ()
                                      {
                                        widget.todo.tableName = widget.tableName;
                                        MyDatabase.localDatabase.delete(subTodo).whenComplete(() {
                                          widget.todo.subTodos.remove(subTodo);
                                          setState(() {});
                                        });

                                      },
                                      child: const Icon(Icons.delete,color: Colors.red,size: 22,),
                                    ),
                                  ),
                                  const SizedBox(width: 60,),
                                  const Icon(Icons.edit,color: Colors.teal,size: 22,),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text(subTodo.title,style: const TextStyle(
                                          fontFamily: "Almarai",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w100),),
                                      SizedBox(width: 20,height:20,child: CheckBoxWidget(color: widget.color, todoModel: widget.todo, index: 0, tableName:widget.tableName,)),
                                      const SizedBox(width: 18,),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Text('${subTodo.toDoTime!.month}/${subTodo.toDoTime!.day}/${subTodo.toDoTime!.hour}:${subTodo.toDoTime!.minute}',
                                      style: const TextStyle(fontFamily: "Almarai",fontSize: 14,color: Colors.grey,fontWeight: FontWeight.normal),),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                  ).toList(),
                )
                :const SizedBox(),

                //"اضف المهمة"
                const SizedBox(height: 15,),
                Consumer<ToDosController>(builder: (context,value,_){
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width*0.24,
                        vertical: MediaQuery.of(context).size.height*0.05),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: ()async{
                            if(_todoTitle.text.isNotEmpty)
                            {

                              widget.todo.title = _todoTitle.text;
                              widget.todo.details = _todoDetails.text;
                              widget.todo.category = value.category;
                              widget.todo.toDoTime = value.data;
                              widget.todo.remind = value.data;
                              widget.todo.isDone = false;
                              widget.todo.tableName = widget.tableName;

                              value.updateToDo(widget.todo);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ToDosPage(color: widget.color, tableName: widget.tableName, title: '',)),
                              );

                            }
                          },
                          child: Text("تعديل المهمة", style: TextStyle(fontSize: 24,color: widget.color,fontFamily: "Almarai",fontWeight: FontWeight.w900),),
                        ),
                      ],
                    ),
                  );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }

}
