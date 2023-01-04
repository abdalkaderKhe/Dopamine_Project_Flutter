import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/todo.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckBoxWidget extends StatefulWidget {
  ToDo todoModel;
  Color color;
  int index;
  String tableName;

  CheckBoxWidget({Key? key,required this.color,required this.todoModel,required this.index,required this.tableName,}) : super(key: key);
  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}
class _CheckBoxWidgetState extends State<CheckBoxWidget> {

  bool? isDone;

  @override
  void initState() {
    isDone = widget.todoModel.isDone;
    super.initState();
  }
  //bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return widget.color;
    }

    return Consumer<ToDosController>(
      builder: (context,todo,_){
        return Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isDone,
          onChanged: (bool? value) {
            setState(() {
              isDone = value!;
              todo.checkIsDone(tableName: widget.tableName, index: widget.index, value: value);
              /*
              todo.getToDosFromModel(widget.tableName)[widget.index].isDone = value!;
              widget.todoModel.isDone = value;
              for(int i =0 ; i<widget.todoModel.subTodos.length;i++)
              {
                widget.todoModel.subTodos[i].isDone = value;
              }
              MyDatabase.localDatabase.update(widget.todoModel);
               */
            });
          },

        );
      },
    );
  }
}