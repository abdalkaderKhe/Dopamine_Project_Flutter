import 'package:eisenhower_matrix/controller/timer_controller.dart';
import 'package:eisenhower_matrix/ui/widgets/progress_widget.dart';
import 'package:eisenhower_matrix/ui/widgets/timer_card.dart';
import 'package:eisenhower_matrix/ui/widgets/timer_controller.dart';
import 'package:eisenhower_matrix/ui/widgets/timer_options.dart';
import 'package:eisenhower_matrix/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerController>(context);
    return Scaffold(
      backgroundColor: renderColor(provider.currentState),
      appBar: AppBar(
        elevation: 0,
          backgroundColor: renderColor(provider.currentState),
        title: Text("POMOTIMER",style: textStyle(25,Colors.white,FontWeight.w700),),
        actions: [
          IconButton(onPressed:  (){
            Provider.of<TimerController>(context,listen: false).reset();
          }, icon:const Icon(Icons.refresh,color: Colors.white,),iconSize: 40,),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children:
            [
              const SizedBox(height: 15,),
              const TimerCard(),
              const SizedBox(height: 40,),
              TimerOptions(),
              const SizedBox(height: 40,),
              const TimerControllerWidget(),
              const SizedBox(height: 40,),
              const ProgressWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
