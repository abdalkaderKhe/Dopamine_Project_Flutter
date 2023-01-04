import 'package:eisenhower_matrix/model/videos_app/section_screen.dart';
import 'package:eisenhower_matrix/ui/pages/videos_app/section_page.dart';
import 'package:flutter/material.dart';

class SectionsPage extends StatefulWidget {
  @override
  State<SectionsPage> createState() => _SectionsPageState();
  bool appBarShow;
  SectionsPage({required this.appBarShow});
}

class _SectionsPageState extends State<SectionsPage> {

  List<SectionReligionScreenModel> sections = [];

  late SectionReligionScreenModel sectionsMap = SectionReligionScreenModel(imageUrl: '', title: '');

  @override
  void initState()  {
    for(int i = 0 ; i<sectionReligionScreenModel.length;i++){
        sections.add(sectionReligionScreenModel[i]);
    }
    print(sectionsMap.sectionsMap[0]['title']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      //backgroundColor: Colors.white,
      body:Padding(
        padding: const EdgeInsets.only(top:0.0,left: 8,right: 8,bottom: 8),
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.82,
          children:
          List.generate(sections.length, (index) {
            return buildSectionGridItem(context: context, name: sections[index].title, imageUrl: sections[index].imageUrl, index: index);
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Section(sectionName: sections[index].title,)));
                },
                child: ClipRRect(
                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: Image.asset(
                    sectionsMap.sectionsMap[index]['imageUrl'],
                    //imageUrl,
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
                      sectionsMap.sectionsMap[index]['title'],//name,
                      style:const TextStyle(color:Color(0xFF515151),fontSize: 16,fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis,
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
  Widget createRatingBar(double rating){
    return Row(
      children: [
        for(int i=1;i<=rating;i++) Icon(Icons.star, color: Colors.yellow[700], size: 12),
        for(int i=1;i<=(5-rating);i++) Icon(Icons.star_border, color: Colors.yellow[700], size: 12),
      ],
    );
  }

}