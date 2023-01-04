import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/db/database_model.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/category.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/services/local_notification_servies.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/add_multiple_task_page.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/home_page.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/todos_page.dart';
import 'package:eisenhower_matrix/ui/widgets/drop_down_list_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_multiple_sub_task_page.dart';
class AddToDoPage extends StatefulWidget {
  Color color;
  String tableName;
  AddToDoPage({Key? key,required this.color, required this.tableName}) : super(key: key);
  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime data = DateTime.now();
  DateTime remindTimeData = DateTime.now();
  final TextEditingController _todoTitle = TextEditingController();
  final TextEditingController _todoDetails = TextEditingController();
  final _timeListTextItemController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildAddMultipleTaskSheet(context),

      appBar:AppBar(
        title: const Text("اضافة مهمة",style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w900),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body:
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
                const SizedBox(height: 35,),

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
                const SizedBox(height: 35,),

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
                const SizedBox(height: 35,),
                Consumer<ToDosController>(
                  builder: (context,value,_){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // الوقت
                        InkWell(
                          onTap: ()async{
                            value.alarmController(data, context);
                          },
                          child:Text("${value.data.day}/${value.data.month}/${value.data.year}  -  ${value.data.hour} : ${value.data.minute}",style:const TextStyle(color: Colors.grey,fontSize: 20),),
                        ),

                        const SizedBox(width: 20,),
                        Icon(Icons.calendar_month,size: 35,color: widget.color,),
                      ],
                    );
                  },
                ),

                // تذكير
                const SizedBox(height: 35,),
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

                //"اضف مهام ضمنية"
                const SizedBox(height: 35,),
                InkWell(
                  onTap: (){
                    if(_todoTitle.text.isNotEmpty){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddMultipleSubTaskPage(
                          color: Colors.red,
                          tableName: widget.tableName,
                          parentToDoName:_todoTitle.text.toString(),
                        )),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      // التذكير
                      Text("اضافة مهام ضمنية",style:TextStyle(fontSize: 18,color: Colors.grey.shade500,fontFamily: "Almarai"),),


                      const SizedBox(width: 20,),
                      Icon(Icons.table_rows_sharp,size: 35,color: widget.color,),
                    ],
                  ),
                ),

                //"اضف المهمة"
                const SizedBox(height: 35,),
                Consumer<ToDosController>(
                  builder: (BuildContext context, value, Widget? child) {
                     return Padding(
                       padding: EdgeInsets.symmetric(
                           horizontal: MediaQuery.of(context).size.width*0.35,
                           vertical: MediaQuery.of(context).size.height*0.05),
                       child: Row(
                         children: [
                           InkWell(
                             onTap: ()async{
                               if(_todoTitle.text.isNotEmpty)
                               {
                                 value.addToDo(
                                   ToDo(
                                     title: _todoTitle.text,
                                     details:  _todoDetails.text,
                                     category: value.category,// categoriesListDropdownButton.dropdownValue,
                                     toDoTime: value.data,
                                     remind: value.data,
                                     isDone: false,
                                     tableName :widget.tableName,
                                     subTodos: [],
                                   ),
                                 );
                                 Navigator.pop(
                                   context,
                                   MaterialPageRoute(builder: (context) => ToDosPage(color: widget.color, tableName: widget.tableName, title: '',)),
                                 );
                               }
                             },
                             child: Text("اضف المهمة", style: TextStyle(fontSize: 18,color: widget.color,fontFamily: "Almarai",fontWeight: FontWeight.w900),),
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

  Widget buildAddMultipleTaskSheet(BuildContext context)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 50,
          color: widget.color,
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AddMultipleTaskPage(color: widget.color, tableName: widget.tableName,)),
              );
            }, child: const Text("اضافة عدة مهام",style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.white,fontWeight: FontWeight.w900),)
            //icon: const Icon(Icons.add , color: Colors.white,size: 35,),
          ),
        ),
      ],
    );
  }

}
