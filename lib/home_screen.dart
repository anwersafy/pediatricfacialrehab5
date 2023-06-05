import 'package:flutter/material.dart';
import 'Levels_data/level_score_data.dart';
import 'helper/colors.dart';
import 'level.dart';

import 'Levels_data/level_score_data.dart';
import 'helper/assets_helper.dart';

class MainLevelScreen extends StatelessWidget {
   MainLevelScreen({Key? key}) : super(key: key);
  var levels=levelsData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        CLevelMain,
        'Levels',
        context
      ),
      body: ListView.separated(
        itemBuilder:(context,index)=> levelsMB(
          context,
        levelScreen(
          label: levelsLabel[index],
          color: levelColor[index],
          levels: levelsLabel[index],
        ),
        levelColor[index],
            levelsLabel[index]
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        itemCount: levelsLabel.length,


      )
    );
  }
}
