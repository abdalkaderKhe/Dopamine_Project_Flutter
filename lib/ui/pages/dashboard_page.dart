import 'package:eisenhower_matrix/config/constants.dart';
import 'package:eisenhower_matrix/controller/notes_controller.dart';
import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/ui/pages/note_app/notes_page.dart';
import 'package:eisenhower_matrix/ui/pages/pomodoro_app/pomodoro_page.dart';
import 'package:eisenhower_matrix/ui/pages/today_todo_list_app/today_todo_list.dart';
import 'package:eisenhower_matrix/ui/pages/videos_app/tab_bar_page.dart';
import 'package:eisenhower_matrix/ui/widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  Card makeDashboardItem(String title, String img, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient:const LinearGradient(
            begin: FractionalOffset(0.0, 0.0),
            end:  FractionalOffset(3.0, -1.0),
            colors: [
              Colors.white,
              Colors.white,
              Colors.white70,
              Colors.white70,
              Colors.white,
              Colors.white,
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(2, 2),
            )
          ],
        )
            : BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient:const LinearGradient(
            begin: FractionalOffset(0.0, 0.0),
            end:  FractionalOffset(3.0, -1.0),
            colors: [
              Colors.white,
              Colors.white70,
              Colors.white,
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 10,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //1.item
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PomodoroPage()));
            }
            if (index == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
            }
            if (index == 2) {
               Navigator.push(context, MaterialPageRoute(builder: (context) =>  NotesPage()));
            }
            if (index == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TodayTodoList()));
            }
            if (index == 4) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TabBarPage()));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              //const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  img,
                  height: 65,
                  width: 65,
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  textAlign:TextAlign.center,
                  title,
                  style:const TextStyle(fontFamily: "Almarai",fontSize: 18,color: Colors.black,fontWeight: FontWeight.w100),
                  ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration.zero, () async {
      Provider.of<ToDosController>(context, listen: false).init();
      Provider.of<NotesController>(context, listen: false).getAllNotes();
    });

    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "اختار القسم الذي تود تصفحه",
                      style:
                      TextStyle(fontFamily: "Almarai",fontSize: 24,color: Colors.black,fontWeight: FontWeight.w100),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "الاقسام :",
                      style:
                       TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              padding: const EdgeInsets.all(2),
              children: [
                makeDashboardItem("مؤقت تقنية الطماطم", "assets/dashboard/pomodoro.png", 0),
                makeDashboardItem("مصفوفة الاولولويات", "assets/dashboard/unnamed.png", 1),
                makeDashboardItem("دفتر الملاحظات", "assets/dashboard/notes-icon.png", 2),
                makeDashboardItem("جدول المهام اليومية", "assets/dashboard/todo.png", 3),
                makeDashboardItem("محتوى خاص بتطوير الذات", "assets/dashboard/4404094.png", 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
