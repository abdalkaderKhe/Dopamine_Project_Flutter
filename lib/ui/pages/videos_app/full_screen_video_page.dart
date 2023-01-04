import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenVideo extends StatefulWidget {
  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
  String videoID;
  FullScreenVideo({required this.videoID});
}
class _FullScreenVideoState extends State<FullScreenVideo> {

  late YoutubePlayerController _youtubePlayerController;

  @override
  void dispose() {
    super.dispose();
    _youtubePlayerController.dispose();
  }

  @override
  void initState() {
    _youtubePlayerController=  YoutubePlayerController(
      initialVideoId:
      YoutubePlayer.convertUrlToId(widget.videoID).toString(),
      flags: const YoutubePlayerFlags(
        hideThumbnail: false,
        autoPlay: false,
        mute: false,
        loop: false,
      ),
    );
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: const Text(
          "اسم الموضوع",
          style:  TextStyle(fontFamily: "Almarai",fontSize: 24,color: Colors.black,fontWeight: FontWeight.w100),
        ),
      ),

      body:Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: GestureDetector(
              child: YoutubePlayer(
                controller: _youtubePlayerController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }


}