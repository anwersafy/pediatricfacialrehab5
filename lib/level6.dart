import 'package:flutter/material.dart';
import '/helper/assets_helper.dart';

import 'Levels_data/level_score_data.dart';
import 'camera.dart';

class levelScreen6 extends StatefulWidget {
  var label;
  var color;
  var levels;
  levelScreen6({Key? key, this.label, this.color, this.levels})
      : super(key: key);
  @override
  State<levelScreen6> createState() => _levelScreen6State();
}



class _levelScreen6State extends State<levelScreen6> {
  var levelData = levelsData();
  List<int> scors=[];
  @override
  void initState() {
    for (int i = 0; i < 3; i++) {
      levelData.getScoreLevels(widget.levels, dbGames[i]).then((value) => setState(() {
        if(value!=null)
        {scors.add(value);}
        else
        {scors.add(0);}
      }));
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: defaultAppBar(widget.color, widget.label, context),
        body: scors.length==3?
        MBlevel6(
    scors,widget.levels
        ):Center(child: CircularProgressIndicator()));




  }
}
