import 'package:eisenhower_matrix/model/videos_app/subjects_screen.dart';
import 'package:eisenhower_matrix/ui/pages/videos_app/full_screen_video_page.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../model/videos_app/section_screen.dart';
import '../../../model/videos_app/video.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
  bool appBarShow;
  String personName , subjectName , sectionName , tag;
  VideoPage({required this.appBarShow,required this.personName
    ,required this.subjectName,required this.sectionName,required this.tag});
}

class _VideoPageState extends State<VideoPage> {
  final List<YoutubePlayerController> _controllers = [];
  List<VideoModel> videoModels = [];
  List<VideoModel> showVideo = [];
  List<SectionReligionScreenModel> section = [];
  List<SubjectsReligionScreenModel> subjects = [];
  @override
  void initState() {
    init();
    super.initState();
  }

  void init()async{
    if(widget.tag != '')
    {
      for (int i = 0; i < videos.length; i++){
        videoModels.add(videos[i]);
        videos[i].tags.forEach((element) {
          if(element == widget.tag){
            showVideo.add(videos[i]);
            _controllers.add(YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(videoModels[i].url).toString(),
              flags: const YoutubePlayerFlags(
                hideThumbnail: false,
                autoPlay: false,
                mute: false,
                loop: false,
              ),
            ));
          }
        });
      }
    }
    for (int i = 0; i < videos.length; i++){
      videoModels.add(videos[i]);
      if(videoModels[i].subject == widget.subjectName){
        showVideo.add(videoModels[i]);
        _controllers.add(YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(videoModels[i].url).toString(),
          flags: const YoutubePlayerFlags(
            hideThumbnail: false,
            autoPlay: false,
            mute: false,
            loop: false,
          ),
        ),
        );
      }
    }
    for (int i = 0; i < showVideo.length; i++){
      for(int j = 0; j < subjectsReligionScreenModel.length; j++){
        if(showVideo[i].subject == subjectsReligionScreenModel[j].title){
          subjects.add(subjectsReligionScreenModel[j]);
        }
      }
    }

  }

  @override
  void dispose() {
    for(int i = 0 ; i<_controllers.length;i++){
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(widget.appBarShow,widget.subjectName),
      body: ListView.builder(
        itemCount: showVideo.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                children: <Widget>[
                  //youtube//
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: GestureDetector(
                      child: YoutubePlayer(
                        controller: _controllers[index],
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // ايقونة القناة ايقونة القسم
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                          backgroundImage: AssetImage(subjects[index].imageUrl),
                        ),

                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(showVideo[index].title, maxLines: 2),
                                  ),
                                  const SizedBox(width: 5),
                                  IconButton(
                                    alignment: Alignment.topCenter,
                                    icon:const Icon(Icons.share, size: 22),
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 5),
                                  IconButton(
                                    alignment: Alignment.topCenter,
                                    icon:const Icon(Icons.aspect_ratio_outlined, size: 22),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenVideo(videoID: showVideo[index].url,)));
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                              //tags
                              Padding(
                                padding:const EdgeInsets.only(left: 8,right: 8),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  child: getListView(showVideo[index]),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ],
          );
        },
      ),
    );
  }
  Widget _simpleDetailinfo() {
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.withOpacity(0.5),
            backgroundImage:const AssetImage("assets/images/tsof.jpg"),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(_controllers[0].metadata.title, maxLines: 2),
                    ),
                    IconButton(
                      alignment: Alignment.topCenter,
                      icon: const Icon(Icons.more_vert, size: 18),
                      onPressed: () {},
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "videos[0].title",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    const Text(" · "),
                    Text(
                      "5",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    const Text(" · "),
                    Text(
                      //  DateFormat("yyyy-MM-dd").format(widget.video.snippet.publishTime),
                      "yyyy-MM-dd",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget getListView(VideoModel showVideo) {
    int itemCount = showVideo.tags.length;
    List<String> tags =[];
    var list = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                VideoPage(appBarShow: true, subjectName: '', tag: showVideo.tags[index], sectionName: '', personName: '',)));
          }, child: Text(showVideo.tags[index] + "#", style: const TextStyle(color: Colors.orange),));
        });
    return list;
  }
  AppBar buildAppBar(bool appBarShow , String title) {
    if (appBarShow == false) {
      return AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      );
    } else {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.black54),
        ),
      );
    }
  }
}