import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/category.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/ui/pages/note_app/notes_page.dart';
import 'package:eisenhower_matrix/ui/pages/pomodoro_app/pomodoro_page.dart';
import 'package:eisenhower_matrix/ui/pages/today_todo_list_app/today_todo_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../pages/eisenhower_matrix_app/home_page.dart';
import 'check_box_widget.dart';
import 'package:eisenhower_matrix/config/constants.dart';
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 3;
  List<String> sortedByItems = ["حسب الابجدية","الاقرب","الابعد","الاقدم","الاحدث"];
  String sortType ="";
  List<bool> checkBoxesIsCheckedList = [];

    @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context)
  {
    final size  = MediaQuery.of(context).size;

    return Scaffold(

bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle:const TextStyle(fontFamily: "Almarai",color: Color.fromRGBO(73, 70, 97, 1),fontSize: 11,fontWeight: FontWeight.bold),
        unselectedLabelStyle :const TextStyle(fontFamily: "Almarai",color: Color.fromRGBO(73, 70, 97, 1),fontSize: 11,fontWeight: FontWeight.bold),
        type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Colors.grey.shade600,
        iconSize: 28,

        onTap: (index) => setState(() {
          currentIndex = index;
        }),

        items: [
          BottomNavigationBarItem(icon: InkWell(child:const Icon(Icons.delete,),onTap: (){_deleteBottomSheetMenu();},),  label: "حذف",backgroundColor: Colors.grey),
          BottomNavigationBarItem(icon: InkWell(child:const Icon(Icons.sort,),onTap: (){_sortBottomSheetMenu();},),label: "ترتيب",backgroundColor: Colors.grey),
          BottomNavigationBarItem(icon: InkWell(child:const Icon(Icons.filter_alt_rounded,),onTap: (){_filterBottomSheetMenu();},),label: "فلتر",backgroundColor: Colors.grey),
          BottomNavigationBarItem(icon: InkWell(onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  const PomodoroPage(),
              ),
            );
          },child:SizedBox(height:31,width:31,child: Image.asset("assets/dashboard/pomodoro.png",),),), label: "pomodoro",backgroundColor: Colors.grey),

          /*
           BottomNavigationBarItem(icon: InkWell(child:const Icon(Icons.featured_play_list_rounded,color: Colors.indigo,),onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TodayTodoList(),
              ),
            );
          },),label: "مهام اليوم",backgroundColor: Colors.indigo),
          BottomNavigationBarItem(icon: InkWell(child:const Icon(Icons.note_alt_rounded,color: Colors.indigo,),
            onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  NotesPage(),
              ),
            );
          },
          ),label: "ملاحظات",backgroundColor: Colors.indigo),
           */

        ],

      ),

      body: const HomePage(),
    );
  }


  void _deleteBottomSheetMenu() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
          context: context,
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (builder) {
            return GestureDetector(
              child: Container(
                height: 100,
                color: Colors.transparent,
                padding:const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("حذف المهام",style: TextStyle(fontFamily: "Almarai",color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18,),),
                    Consumer<ToDosController>(builder: (context,value,_){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(onTap: ()async{await value.deleteAllTasks().whenComplete((){Navigator.pop(context);});},child: const Text("حذف الكل",style: TextStyle(fontFamily: "Almarai",color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 16,),)),
                          const SizedBox(width: 30,),
                          InkWell(onTap: ()async{await value.deleteDoneTasks().whenComplete((){Navigator.pop(context);});}, child: const Text("حذف المهام المنتهية",style: TextStyle(fontFamily: "Almarai",color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 16,),)
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            );
          }
          );
    });
  }

  void _sortBottomSheetMenu() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(

          context: context,
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),

          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (builder) {
            return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState){
                  return GestureDetector(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.36,
                      color: Colors.transparent,
                      padding:const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Consumer<ToDosController>(builder: (context,data,_){
                           return Column(
                             children: [
                               RadioListTile(
                                 title: Text(sortedByItems[1],style:TextStyle(fontSize: 18,color: Colors.grey.shade500,fontFamily: "Almarai"),),
                                 value: sortedByItems[1],
                                 groupValue: sortType,
                                 onChanged: (value)async{
                                   setState((){
                                     sortType = value!;
                                   });
                                   await data.sortByClosest();
                                 },
                               ),
                               RadioListTile(
                                 title: Text(sortedByItems[2],style:TextStyle(fontSize: 18,color: Colors.grey.shade500,fontFamily: "Almarai"),),
                                 value: sortedByItems[2],
                                 groupValue: sortType,
                                 onChanged: (value) async {
                                   setState((){
                                     sortType = value!;
                                   });
                                   await data.sortByFurthest();
                                 },
                               ),
                               RadioListTile(
                                 title: Text(sortedByItems[4],style:TextStyle(fontSize: 18,color: Colors.grey.shade500,fontFamily: "Almarai"),),
                                 value: sortedByItems[4],
                                 groupValue: sortType,
                                 onChanged: (value){
                                   setState(() {
                                     sortType = value!;
                                   });
                                 },
                               ),
                               const SizedBox(height: 10,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   InkWell(
                                       onTap: (){Navigator.pop(context);},
                                       child: Text("ترتيب",style:TextStyle(fontSize: 20,color: Colors.grey.shade500,fontFamily: "Almarai"),)),
                                 ],
                               ),
                             ],
                           );
                         })
                        ],
                      ),
                    ),
                  );
                }
            );
          }
          );
    });
  }

  void _filterBottomSheetMenu() {

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,

          builder: (builder) {
            return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState){
                  return Consumer<ToDosController>(
                   builder: (context,data,_){
                     return GestureDetector(
                       child: Container(
                         height: MediaQuery.of(context).size.height * (data.getCategoriesContentFromModel().length * 90) / 1000,
                         color: Colors.transparent,
                         padding:const EdgeInsets.all(30),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Column(
                               children: [
                                 ListView.builder(
                                   shrinkWrap: true,
                                   scrollDirection : Axis.vertical,
                                   itemCount: data.getCategoriesContentFromModel().length,
                                   itemBuilder: (BuildContext context, int index) {
                                     data.getCategoriesContentFromModel().forEach((element) {
                                       checkBoxesIsCheckedList.add(false);
                                     });
                                     return Consumer<ToDosController>(builder: (context,data,_){
                                       return Row(
                                         children: [
                                           Checkbox(
                                             checkColor: Colors.white,
                                             value: checkBoxesIsCheckedList[index],
                                             onChanged: (bool? value)async {
                                               setState(() {
                                                 checkBoxesIsCheckedList[index] = value!;
                                                 //print(checkBoxesIsCheckedList[index]);
                                               });
                                               await data.filterByCategory(data.getCategoriesContentFromModel()[index],checkBoxesIsCheckedList[index]);
                                             },
                                           ),
                                           Text(data.getCategoriesContentFromModel()[index],style:TextStyle(fontSize: 18,color: Colors.grey.shade500,fontFamily: "Almarai"),),
                                         ],
                                       );
                                     });
                                   },
                                 ),
                                 const SizedBox(height: 5,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     Text("تحرير",style:TextStyle(fontSize: 20,color: Colors.grey.shade500,fontFamily: "Almarai"),),
                                     const SizedBox(width: 35,),
                                     InkWell(onTap: (){Navigator.pop(context);}, child: Text("ترتيب",style:TextStyle(fontSize: 20,color: Colors.grey.shade500,fontFamily: "Almarai"),)),

                                   ],
                                 )
                               ],
                             )
                           ],
                         ),
                       ),
                     );
                   },
                  );
                }
            );
          }

          );
    });
  }

}

/*
bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle:const TextStyle(fontFamily: "Almarai",color: Color.fromRGBO(73, 70, 97, 1),fontSize: 11,fontWeight: FontWeight.bold),
        unselectedLabelStyle :const TextStyle(fontFamily: "Almarai",color: Color.fromRGBO(73, 70, 97, 1),fontSize: 11,fontWeight: FontWeight.bold),
        type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Colors.grey.shade600,
        iconSize: 28,

        onTap: (index) => setState(() {
          currentIndex = index;
        }),

        items: [
          BottomNavigationBarItem(icon: InkWell(child:const Icon(Icons.delete,),onTap: (){_deleteBottomSheetMenu();},),  label: "حذف",backgroundColor: Colors.grey),
          BottomNavigationBarItem(icon: InkWell(child:const Icon(Icons.sort,),onTap: (){_sortBottomSheetMenu();},),label: "ترتيب",backgroundColor: Colors.grey),
          BottomNavigationBarItem(icon: InkWell(child:const Icon(Icons.filter_alt_rounded,),onTap: (){_filterBottomSheetMenu();},),label: "فلتر",backgroundColor: Colors.grey),
          BottomNavigationBarItem(icon: InkWell(onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  const PomodoroPage(),
              ),
            );
          },child:SizedBox(height:31,width:31,child: Image.asset("assets/dashboard/pomodoro.png",),),), label: "pomodoro",backgroundColor: Colors.grey),
          /*
          BottomNavigationBarItem(icon: InkWell(child:const Icon(Icons.featured_play_list_rounded,color: Colors.indigo,),            onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TodayTodoList(),
              ),
            );
          },),label: "مهام اليوم",backgroundColor: Colors.indigo),
          BottomNavigationBarItem(icon: InkWell(child:const Icon(Icons.note_alt_rounded,color: Colors.indigo,),
            onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  NotesPage(),
              ),
            );
          },
          ),label: "ملاحظات",backgroundColor: Colors.indigo),
           */
        ],

      ),
 */
