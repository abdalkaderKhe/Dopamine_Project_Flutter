import 'package:eisenhower_matrix/config/constants.dart';
import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/edite_categories_page.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/todos_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/check_box_widget.dart';
class HomePage extends StatelessWidget {
   const HomePage({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,

      appBar: AppBar(
        automaticallyImplyLeading : true,
        title: const Text("مصفوفة الأولويات",style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w900),),
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        elevation: 1,
        foregroundColor: Colors.black,
      ),

      drawer: Drawer(
        //backgroundColor: Colors.black45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 150,),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditeCategories()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:const
                  [
                   Padding(padding: EdgeInsets.only(bottom: 6),
                       child:Text(
                     "تحرير الاصناف",
                     textAlign:TextAlign.center,
                     style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w100,),
                   ),),
                   SizedBox(width: 20,),
                   Icon(Icons.filter_alt_outlined,size: 30,),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:const
                  [
                    Padding(padding: EdgeInsets.only(bottom: 6),
                      child:Text(
                        "الاشعارات",
                        textAlign:TextAlign.center,
                        style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w100,),
                      ),),
                    SizedBox(width: 20,),
                    Icon(Icons.notifications_active_outlined,size: 30,),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:const
                  [
                    Padding(padding: EdgeInsets.only(bottom: 6),
                      child:Text(
                        "حذف الاعلانات",
                        textAlign:TextAlign.center,
                        style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w100,),
                      ),),
                    SizedBox(width: 20,),
                    Icon(Icons.shopping_cart_outlined,size: 30,),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:const
                  [
                    Padding(padding: EdgeInsets.only(bottom: 6),
                      child:Text(
                        "شارك المهام",
                        textAlign:TextAlign.center,
                        style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w100,),
                      ),),
                    SizedBox(width: 20,),
                    Icon(Icons.share,size: 30,),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:const
                  [
                    Padding(padding: EdgeInsets.only(bottom: 6),
                      child:Text(
                        "PDF تصدير بصيغة ",
                        textAlign:TextAlign.center,
                        style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w100,),
                      ),),
                    SizedBox(width: 20,),
                    Icon(Icons.picture_as_pdf,size: 30,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          color: PRIMARY_COLOR,
          child:
          //isLoading ? const Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            child: Column(
              children: [

                buildAdsBanner(),

                Consumer<ToDosController>(
                    builder: (context,value,_){
                      return SizedBox(
                        child: GridView.count(

                          primary: false,
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 6.6 / 10.0,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: <Widget>[

                            InkWell(
                              // 'عاجل و مهم'
                              child: buildToDosList(title:'عاجل و مهم', color: Colors.red, todosTable:value.urgentAndImportantToDosDate,),

                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ToDosPage(
                                    color: Colors.red,
                                    tableName: toDosUrgentAndImportantTable, title: 'عاجل و مهم',
                                  )),
                                );
                              },
                            ),

                            InkWell(
                              child: buildToDosList(
                                title: 'غير عاجل و مهم',
                                color: Colors.deepPurple,
                                todosTable: value.notUrgentAndImportantToDosDate,
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      ToDosPage(color: Colors.deepPurple,
                                        tableName: toDosUrgentAndUnimportantTable, title: 'غير عاجل و مهم',
                                      ),
                                  ),
                                );
                              },
                            ),

                            InkWell(
                              child: buildToDosList(title: 'عاجل و غير مهم', color: Colors.blueGrey, todosTable: value.urgentAndUnimportantToDosDate),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      ToDosPage(color: Colors.blueGrey,
                                        tableName: toDosNotUrgentAndImportantTable, title: 'عاجل و غير مهم',
                                      ),
                                  ),
                                );
                              },
                            ),

                            InkWell( //notUrgentNotImportantToDosDate
                              child: buildToDosList(title: 'غير عاجل و غير مهم', color: Colors.green, todosTable: value.notUrgentNotImportantToDosDate),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      ToDosPage(
                                        color: Colors.green,
                                        tableName: toDosNotUrgentNotImportantTable, title:'غير عاجل و غير مهم',
                                      ),
                                  ),
                                );
                              },
                            ),

                          ],
                        ),
                      );
                    }
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildToDosList({required String title, required Color color , required List<ToDo> todosTable})
  {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 2,
          color: color,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(title,style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: color,fontWeight: FontWeight.w900),),
          ),
          Divider(height: 12,color: color,thickness: 1.3,),
          SizedBox(
            height: 220,
            child:  SingleChildScrollView(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: todosTable.length,
                  itemBuilder: (context, index){
                    return buildUrgentAndImportantToDo(color: color, todos: todosTable, index: index,);
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUrgentAndImportantToDo({required Color color,required List<ToDo> todos ,required int index})
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Text(
                  todos[index].title,
                  style: TextStyle(
                      decoration: todos[index].isDone ? TextDecoration.lineThrough : TextDecoration.none,
                      fontFamily: "Almarai",
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      todos[index].category.toString(),
                      style: TextStyle(
                          fontFamily: "Almarai",
                          fontSize: 11,
                          color: color,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
            const SizedBox(width: 4,),
            //CheckBoxWidget(color: color,),
          ],
        ),
        const  Divider(height: 2.272,color: Colors.grey,thickness: 1.5,),
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


























/*
    Widget buildToDosColumn({required String title, required Color color})
  {
    return Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: GlobalStyle.PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 2,
            color: color,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(title,style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: color,fontWeight: FontWeight.w900),),
            ),
            Divider(height: 12,color: color,thickness: 1.3,),

            SizedBox(
              height: 220,
              child: SingleChildScrollView(
                child: ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index){
                      return buildToDo(color: color,);
                    }
                ),
              ),
            ),

          ],
        ),
    );
  }
   */
/*
   Widget buildToDo({required Color color})
   {
     bool isDone = false;
     return Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const SizedBox(
                   height: 4,
                 ),
                 Text(
                   "كورس الانكليزي",
                   style: TextStyle(
                       decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
                       fontFamily: "Almarai",
                       fontSize: 13,
                       color: Colors.black,
                       fontWeight: FontWeight.bold),
                 ),
                 const SizedBox(
                   height: 4,
                 ),
                 Row(
                   children: [
                     const   Icon(
                       Icons.access_alarm,
                       size: 15,
                       color: Colors.grey,
                     ),
                     const  Icon(
                       Icons.update,
                       size: 15,
                       color: Colors.grey,
                     ),
                     const  Icon(
                       Icons.note_alt,
                       size: 15,
                       color: Colors.grey,
                     ),
                     Text(
                       "الدراسة",
                       style: TextStyle(
                           fontFamily: "Almarai",
                           fontSize: 11,
                           color: color,
                           fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
               ],
             ),
             //CheckBoxWidget(color: color, isDone: false, todoModel: null,),
           ],
         ),
         const  Divider(height: 2.272,color: Colors.grey,thickness: 1.3,),
       ],
     );
   }
   */

