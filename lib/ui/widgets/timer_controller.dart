import 'package:eisenhower_matrix/controller/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerControllerWidget extends StatefulWidget {
  const TimerControllerWidget({Key? key}) : super(key: key);
  @override
  State<TimerControllerWidget> createState() => _TimerControllerWidgetState();
}

class _TimerControllerWidgetState extends State<TimerControllerWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerController>(context);
    return Container(
      width: 100,
      height: 100,
      decoration:const BoxDecoration(color: Colors.black26,shape: BoxShape.circle),
      child: Center(
        child: IconButton(
          icon:provider.timerPlaying ? const Icon(Icons.pause)  : const Icon(Icons.play_arrow_sharp),
          color: Colors.white,
          iconSize: 55,
          onPressed: (){
            provider.timerPlaying ?  Provider.of<TimerController>(context,listen:false).pause()  :  Provider.of<TimerController>(context,listen:false).start() ;
          },
        ),
      ),
    );
  }
}
