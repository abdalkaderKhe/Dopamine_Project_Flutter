import 'package:eisenhower_matrix/controller/timer_controller.dart';
import 'package:eisenhower_matrix/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerController>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${provider.rounds}/4",style:textStyle(25,Colors.grey[350],FontWeight.w700)),
            Text("${provider.goal}/12",style:textStyle(25,Colors.grey[350],FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("ROUND",style:textStyle(25,Colors.white,FontWeight.w700)),
            Text("GOAL",style:textStyle(25,Colors.white,FontWeight.w700)),
          ],
        ),
      ],
    );
  }
}
