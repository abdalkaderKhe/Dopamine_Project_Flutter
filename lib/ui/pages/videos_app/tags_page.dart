import 'package:eisenhower_matrix/model/videos_app/video.dart';
import 'package:eisenhower_matrix/ui/pages/videos_app/video-page.dart';
import 'package:flutter/material.dart';

class TagsPage extends StatefulWidget {
  @override
  State<TagsPage> createState() => _TagsPageState();
  bool appBarShow;
  String personName;
  String sectionName;
  TagsPage({required this.appBarShow,required this.personName,required this.sectionName});
}

class _TagsPageState extends State<TagsPage> {
  List<VideoModel> videosList = [];
  List<String> tags = [];
  List<String> tag = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  init()async{

    if(widget.sectionName == '' && widget.personName == ''){

      for(int i = 0 ; i<videos.length;i++){
        videosList.add(videos[i]);
        for(var element in videosList[i].tags) {
          tags.add(element);
        }
      }
      var seen = Set<String>();
      tag = tags.where((country) => seen.add(country)).toList();
    }

    else if (widget.sectionName != ''){
      for(int i = 0 ; i<videos.length;i++){
        videosList.add(videos[i]);
        if(videosList[i].sectionName == widget.sectionName){
          videosList.add(videos[i]);
          for (var element in videosList[i].tags) {
            tags.add(element);
          }
        }
      }
      var seen = Set<String>();
      tag = tags.where((country) => seen.add(country)).toList();
    }
    else if (widget.personName != ''){
      for(int i = 0 ; i<videos.length;i++){
        videosList.add(videos[i]);
        if(videosList[i].person_name == widget.personName){
          videosList.add(videos[i]);
          for (var element in videosList[i].tags) {
            tags.add(element.toString());
          }
        }
      }
      var seen = Set<String>();
      tag = tags.where((country) => seen.add(country)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body:Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            children:
            List.generate(tag.length, (index) {
              return Center(
                  child:TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        VideoPage(subjectName: '', appBarShow: true,  tag: tag[index], sectionName: '', personName: '',)),
                    ) ;
                  },
                      child: Text(tag[index] + "#", style: TextStyle(color: Colors.orange,fontSize: 22),textAlign:TextAlign.center,))
              );
            },
            ),
          ),
        )
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
}
