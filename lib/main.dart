import 'package:eisenhower_matrix/config/constants.dart';
import 'package:eisenhower_matrix/controller/notes_controller.dart';
import 'package:eisenhower_matrix/controller/timer_controller.dart';
import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/category.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/ui/pages/dashboard_page.dart';
import 'package:eisenhower_matrix/ui/pages/eisenhower_matrix_app/home_page.dart';
import 'package:eisenhower_matrix/ui/widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<TimerController>(
              create: (_) => TimerController(),
            ),
           ChangeNotifierProvider<ToDosController>(
              create: (context) => ToDosController(),
           ),
            ChangeNotifierProvider<NotesController>(
              create: (context) => NotesController(),
            ),
          ],
        child:const MyApp(),
      ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primaryColor:PRIMARY_COLOR,
        scaffoldBackgroundColor:PRIMARY_COLOR,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const DashboardPage(),
      //home: const PageTest(),
    );
  }
}
