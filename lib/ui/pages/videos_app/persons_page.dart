import 'package:eisenhower_matrix/model/videos_app/person_screen.dart';
import 'package:eisenhower_matrix/ui/pages/videos_app/person_page.dart';
import 'package:flutter/material.dart';

class PersonsPage extends StatefulWidget {
  @override
  State<PersonsPage> createState() => _PersonsPageState();
  bool appBarShow;
  String sectionName;
  PersonsPage({required this.appBarShow,required this.sectionName});
}

class _PersonsPageState extends State<PersonsPage> {
  //List<PersonReligionScreenModel> persons = [];
  List<Map> personsMap = [];
  PersonReligionScreenModel personReligionScreenModel = PersonReligionScreenModel(name: '', imageUrl: '', section: '');

  @override
  void initState() {

    if(widget.sectionName == '')
    {
      for(int i = 0 ; i<personsReligionScreen.length;i++){
          //persons.add(personsReligionScreen[i]);
         personsMap.add(personReligionScreenModel.personsMap[i]);
      }
    }
    else
    {

      for(int i = 0 ; i<personReligionScreenModel.personsMap.length;i++)
      {
        if(personReligionScreenModel.personsMap[i]['section'] == widget.sectionName)
        {
          personsMap.add(personReligionScreenModel.personsMap[i]);
        }
      }
      /*
      for(int i = 0 ; i<personsReligionScreen.length;i++){
        if(personsReligionScreen[i].section == widget.sectionName){
          persons.add(personsReligionScreen[i]);
        }
      }
       */

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body:Padding(
        padding: const EdgeInsets.only(top:0.0,left: 5,right: 5,bottom: 5),
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          childAspectRatio: 0.75,
          children:
          List.generate(personsMap.length, (index) {
            return buildSectionGridItem(context: context, name: personsMap[index]['name'], imageUrl: personsMap[index]['imageUrl'], index: index);
          }),
        ),
      ),
    );
  }

  AppBar buildAppBar(bool appBarShow)
  {
    if(appBarShow == false){
      return AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,elevation: 0,shadowColor:Colors.transparent,);
    }else{
      return AppBar(
        centerTitle: false,
        backgroundColor: Colors.red.shade800,
        title: const Text("دين",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      );
    }
  }
  Widget buildSectionGridItem({required context,required name,required imageUrl,required int index})
  {
    final double boxImageSize = ((MediaQuery.of(context).size.width)-50)/2-50;
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  PersonScreen(personName: personsMap[index]['name'],)));
                },
                child: ClipRRect(
                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: boxImageSize,
                    height: boxImageSize,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:const TextStyle(color:Color(0xFF515151),fontSize: 13,fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}