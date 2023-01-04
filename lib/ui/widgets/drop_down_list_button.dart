import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/category.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesListDropdownButton extends StatefulWidget {
  List<String> list;
  String dropdownValue;
  CategoriesListDropdownButton({super.key , required this.list , required this.dropdownValue});
  @override
  State<CategoriesListDropdownButton> createState() => _CategoriesListDropdownButtonState();
}

class _CategoriesListDropdownButtonState extends State<CategoriesListDropdownButton> {

  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first.toString();
  }

  void axisDropdownValue()
  {
     widget.dropdownValue = dropdownValue;
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDosController>(builder: (context,data,_){
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: Colors.grey, style: BorderStyle.solid, width: 0.80),
          ),
          alignment: Alignment.center,
          height: 50,
          width: 300,
          //padding: EdgeInsets.all(0),
          child: DropdownButton<String>(
            isExpanded : true,
            value: dropdownValue,
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
                dropdownValue = value!;
                axisDropdownValue();
                data.getCategory(value);
              });

            },
            items: widget.list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      );
    });
  }


}