import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pediatricfacialrehab/helper/assets_helper.dart';
import 'package:pediatricfacialrehab/widgets/background.dart';

import 'main_level.dart';

class GameReward extends StatelessWidget{
  final int score;

  GameReward({Key? key, required this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//backgroundColor: Colors.green[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            score>5?Text('Congratulations!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.green
            ),):Text('Good Luck Next Time'
              , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.red
            ),),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
           // Text('You have completed the game'),
            //Image(image: AssetImage('assets/images/Group-3-copy.png')),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return Icon(
                index < score~/10 ? Icons.star : Icons.star_border,
                color: Colors.amber,
              size: 64,
              );
            }),
          ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

            Text('Your score is $score', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,

            ),),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                navigateToAndFinish(context: context, widget: levelsScreen());

              },
              child: Text('  Next  '),
            ),

          ],
        ),
      ),
    );
  }


}