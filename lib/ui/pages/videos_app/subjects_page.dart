import 'package:eisenhower_matrix/model/videos_app/subjects_screen.dart';
import 'package:eisenhower_matrix/ui/pages/videos_app/video-page.dart';
import 'package:flutter/material.dart';

class SubjectsPage extends StatefulWidget {
  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
  bool appBarShow;
  String personName;
  String sectionName;
  SubjectsPage({required this.appBarShow,required this.sectionName,required this.personName});
}

class _SubjectsPageState extends State<SubjectsPage> {
  //List<SubjectsReligionScreenModel> subjects = [];
  List<Map> subjectsMap = [];
  SubjectsReligionScreenModel subjectsModel = SubjectsReligionScreenModel(imageUrl: '', title: '', personName: '', sectionName: '');

  @override
  void initState() {

    if(widget.sectionName == '' && widget.personName == ''){
      for(int i = 0 ; i<subjectsModel.subjectsMap.length;i++){
        subjectsMap.add(subjectsModel.subjectsMap[i]);
        //subjects.add(subjectsReligionScreenModel[i]);
      }
    }

    else if(widget.sectionName != '')
    {
      for(int i = 0 ; i<subjectsModel.subjectsMap.length;i++){
        if(subjectsModel.subjectsMap[i]['sectionName'] == widget.sectionName)
        {
            subjectsMap.add(subjectsModel.subjectsMap[i]);
            //subjects.add(subjectsReligionScreenModel[i]);
        }
      }
    }
    else if(widget.personName != '')
    {
      for(int i = 0 ; i<subjectsModel.subjectsMap.length;i++){
        if(subjectsModel.subjectsMap[i]['personName'] == widget.personName){
          subjectsMap.add(subjectsModel.subjectsMap[i]);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar:buildAppBar(widget.appBarShow),
      body:Padding(
        padding: const EdgeInsets.only(top:0.0,left: 8,right: 8,bottom: 8),
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.82,
          children:
          List.generate(subjectsMap.length, (index) {
            return buildSectionGridItem(context: context, name: subjectsMap[index]['title'], imageUrl: subjectsMap[index]['imageUrl'], index: index);
          }),
        ),
      ),
    );
  }

  AppBar buildAppBar(bool appBarShow){
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

  Widget buildSectionGridItem({required context,required name,required imageUrl,required int index}){
    final double boxImageSize = ((MediaQuery.of(context).size.width)-24)/2-12;
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      VideoPage(
                        appBarShow: true,
                        subjectName: subjectsMap[index]['title'],
                        personName: widget.personName,
                        sectionName: widget.sectionName,
                        tag: '',
                      )));
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