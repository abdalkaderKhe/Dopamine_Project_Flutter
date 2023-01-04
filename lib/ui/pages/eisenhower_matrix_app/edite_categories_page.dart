import 'package:eisenhower_matrix/config/constants.dart';
import 'package:eisenhower_matrix/controller/todos_controller.dart';
import 'package:eisenhower_matrix/model/eisenhower_matrix_app/category.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class EditeCategories extends StatefulWidget {
  const EditeCategories({Key? key}) : super(key: key);
  @override
  State<EditeCategories> createState() => _EditeCategoriesState();
}
class _EditeCategoriesState extends State<EditeCategories> {
  final contentTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading : false,
        title: const Text("تحرير الاصناف",style: TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.black,fontWeight: FontWeight.w900),),
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body:
      SafeArea(
        child:Consumer<ToDosController>(
          builder: (context,value,_){
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [


                ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection : Axis.vertical,
                  itemCount: value.categoriesDate.length,
                  separatorBuilder: (BuildContext context, int index)
                  {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return categoryCardItem(size: size, title: value.categoriesDate[index].content.toString(), category: value.categoriesDate[index], index: index,);
                  },
                ),

                Form(
                  key:_formKey,
                  child: Card(
                    color: Colors.grey.shade100,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: InkWell(
                            onTap: ()
                            {
                              if(_formKey.currentState!.validate())
                              {
                                value.addCategory(Category(contentTextEditingController.text.toString()));
                              }
                            },
                            child:const Text("اضافة",style: TextStyle(fontFamily: "Almarai",fontSize: 16,color: Colors.green,fontWeight: FontWeight.w900),),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                          width: size.width * 0.80,
                          child: TextFormField(
                            controller:contentTextEditingController,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            );
          },
        ),
      ),

    );
  }

  Widget categoryCardItem({required final size, required String title,required Category category,required int index })
  {
    return  SizedBox(
      height: size.height * 0.08,
      width: size.width * 0.95,
      child: Card(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Row(
                children: [
                  Consumer<ToDosController>(builder:(context,value,_){
                    return InkWell(
                      onTap: ()
                      {
                        value.deleteCategory(category);
                      },
                      child: const Icon(Icons.delete,color: Colors.red,
                      ),
                    );
                  }),
                ],
              ),
              Text(title,style: const TextStyle(fontFamily: "Almarai",fontSize: 20,color: Colors.green,fontWeight: FontWeight.w900),),
            ],
          ),
        ),
      ),
    );
  }

}
