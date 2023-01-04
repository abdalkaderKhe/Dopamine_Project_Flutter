import 'package:eisenhower_matrix/config/constants.dart';
import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/db/database_model.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/sub_todo.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/services/local_notification_servies.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/add_todo_page.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/edit_todo_page.dart';
import 'package:eisenhower_matrix/ui/pages/pomodoro_app/pomodoro_page.dart';
import 'package:eisenhower_matrix/ui/widgets/check_box_widget.dart';
import 'package:eisenhower_matrix/ui/widgets/drop_down_list_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ToDosPage extends StatefulWidget {
  Color color;
  String tableName;
  String title;
  ToDosPage({Key? key , required this.color,required this.tableName,required this.title}) : super(key: key);

  @override
  State<ToDosPage> createState() => _ToDosPageState();
}

class _ToDosPageState extends State<ToDosPage> {
  bool isSearching = false;
  List<ToDo> searchedTodDosList = [];
  final TextEditingController searchedTodDosListController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,

      appBar: buildAppBar(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildAddTaskSheet(context),

      body:
      SingleChildScrollView(
        child: Column(
          children: [
            buildAdsBanner(),
            Container(
              margin:const EdgeInsets.all(8),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,
                  color: widget.color,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [

                   Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(widget.title,style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: widget.color,fontWeight: FontWeight.w900),),
                   ),

                   Divider(height: 12,color: widget.color,thickness: 1.3,),

                   Consumer<ToDosController>(
                     builder: (context,value,_){
                       //searchedTodDosList =value.getToDosFromModel(widget.tableName);
                       return SizedBox(
                           height: 550,
                           child: SingleChildScrollView(
                             child: ListView.builder(
                                 physics:const ScrollPhysics(),
                                 shrinkWrap: true,
                                 itemCount: isSearching ? searchedTodDosList.length : value.getToDosFromModel(widget.tableName).length,
                                 //itemCount: toDosDate.length,
                                 itemBuilder: (context, index){
                                   return buildToDo(color: widget.color, todos: isSearching ? searchedTodDosList : value.getToDosFromModel(widget.tableName), index: index, context: context,);
                                 }
                             ),
                           )
                       );
                     },
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildToDo({required Color color ,required List<ToDo> todos , required int index , required BuildContext context})
  {
    //isSearching ? todos = searchedTodDosList : todos = todos;

    todos[index].tableName = widget.tableName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        const SizedBox(height: 5,),

        Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Consumer<ToDosController>(
              builder: (context,value,_){
                return Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: InkWell(
                    onTap: ()
                    {
                      value.deleteToDo(todos[index],index,todos[index].tableName);
                    },

                    child: const Icon(Icons.delete,color: Colors.red,),
                  ),
                );
              },
            ),

            InkWell(
              onTap: ()
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EditTodoPage(
                    color: color,
                    tableName: widget.tableName,
                    todo: todos[index],
                  )),
                );
              },
              child: const Icon(Icons.edit,color: Colors.teal,size: 24,),
            ),

            InkWell(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PomodoroPage()),);
              },
              child: SizedBox(height:32,width:32,child: Image.asset("assets/dashboard/pomodoro.png",),),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(
                      todos[index].title.toString(),
                      style: TextStyle(
                        decoration: todos[index].isDone ? TextDecoration.lineThrough : TextDecoration.none,
                        fontFamily: "Almarai",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),// isDone
                    ),

                    const SizedBox(height: 4,),

                    Text(
                      todos[index].category.toString(),
                      style: TextStyle(
                          fontFamily: "Almarai",
                          fontSize: 11,
                          color: color,
                          fontWeight: FontWeight.bold
                      ),
                    ),//category

                    const SizedBox(height: 4,),

                    Text('${todos[index].toDoTime!.year}/${todos[index].toDoTime!.month}/${todos[index].toDoTime!.day}/${todos[index].toDoTime!.hour}:${todos[index].toDoTime!.minute}',
                      style: const TextStyle(fontFamily: "Almarai",fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500),),

                    const SizedBox(height: 4,),

                  ],
                ),
                SizedBox(height: 24.0, width: 24.0,child: CheckBoxWidget(color: color, todoModel: todos[index], index: index, tableName:widget.tableName,), ),
              ],
            ),

          ],
        ),

        const Divider(height: 1,color: Colors.grey,thickness: 0.15,),

        todos[index].subTodos.isNotEmpty ? const SizedBox(height: 0,) : const SizedBox(),
        todos[index].subTodos.isNotEmpty ?
        Column(
          children: todos[index].subTodos.map((subTodo) =>
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
                          Consumer<ToDosController>(
                              builder: (context,value,_)
                              {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: InkWell(
                                    onTap: ()
                                    {
                                      value.deleteSubToDo(subTodo);
                                      todos[index].subTodos.remove(subTodo);
                                    },
                                    child: const Icon(Icons.delete,color: Colors.red,size: 20,),
                                  ),
                                );
                              }
                          ),
                          const SizedBox(width: 40,),
                          const Icon(Icons.edit,color: Colors.teal,size: 20,),
                          const SizedBox(width: 40,),
                          InkWell(
                            onTap: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const PomodoroPage()),);
                            },
                            child: SizedBox(height:28,width:28,child: Image.asset("assets/dashboard/pomodoro.png",),),
                          ),
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
                              SizedBox(width: 20,height:20,child: CheckBoxWidget(color: color, todoModel: todos[index], index: index, tableName:widget.tableName,)),
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
        : const SizedBox(),
        todos[index].subTodos.isNotEmpty ? const SizedBox(height: 10,) : const SizedBox(),

        const Divider(height: 2.272,color: Colors.grey,thickness: 1.3,),
      ],
    );
  }

  Widget buildAddTaskSheet(BuildContext context)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: widget.color,
          child: IconButton(
            alignment : Alignment.centerLeft,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AddToDoPage(color: widget.color, tableName: widget.tableName,)),
              );
            },
            icon: const Icon(Icons.add , color: Colors.white,size: 35,),),
        ),
      ],
    );
  }

  AppBar buildAppBar()
  {
    return AppBar(
      title:
      isSearching
          ?
      Consumer<ToDosController>(
        builder: (context,value,_){
          return SizedBox(
            height: 35,width: 500,
            child: TextField(
              controller: searchedTodDosListController,
              onChanged: (todoTitle){
                searchedTodDosListController.text.isNotEmpty ? isSearching = true : isSearching = false;
                searchedTodDosList = value.getToDosFromModel(widget.tableName).where((element) => element.title.toLowerCase().startsWith(todoTitle)).toList();
                setState(() {});
              },
            ),
          );
        },
      )
          :
      const Text("مصفوفة الأولويات",style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w900),),


      //title: const Text("مصفوفة الأولويات",style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w900),),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      //leading: Icon(Icons.saved_search,size: 18,color: Colors.grey,),
      actions:  [
        Padding(
          padding:const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              setState(() {
                isSearching = true;
              });
            },
            child:const Icon(Icons.search,size: 28,color: Colors.grey,),
          )
        ),
      ],
    );
  }

  Widget buildAdsBanner()
  {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
        child: Container(width: double.infinity,height:60,color: Colors.black45,)
    );
  }
}





