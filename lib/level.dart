import 'package:flutter/material.dart';
import '/helper/assets_helper.dart';

import 'Levels_data/level_score_data.dart';
import 'camera.dart';

class levelScreen extends StatefulWidget {
  var label;
  var color;
  var levels;
  levelScreen({Key? key, this.label, this.color, this.levels})
      : super(key: key);
  @override
  State<levelScreen> createState() => _levelScreenState();
}



class _levelScreenState extends State<levelScreen> {
  var levelData = levelsData();
  List<int> scors=[];
@override
  void initState() {
  Future.delayed(Duration.zero, () async {
    for (int i = 0; i < 6; i++) {
      levelData.getScoreLevels(widget.levels, dbGames[i]).then((value) {
        setState(() {
          if(value!=null)
          {scors.add(value);}
          else
          {scors.add(0);}
        });
      });
    }
  });
  // for (int i = 0; i < 6; i++) {
  //   levelData.getScoreLevels(widget.levels, dbGames[i]).then((value) => setState(() {
  //     if(value!=null)
  //      {scors.add(value);}
  //     else
  //       {scors.add(0);}
  //   }));
  // }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return scors.length==6?Scaffold(
        appBar: defaultAppBar(widget.color, widget.label, context),
        body: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  navigateToAndFinish(context: context, widget:  CameraPage(
                            reaction:gameLabel2[index],
                                video: videos[index],
                            levels:widget.levels,
                            games:dbGames[index],
                                color: widget.color,
                              ));
                },
                child: Container(

                  child: SingleChildScrollView(

                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CircleAvatar(
                          backgroundColor: widget.color,
                          radius: 54,
                          child: CircleAvatar(
                              radius: 50, child: Image.asset(imgLevel[index])),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text("Game  ${index + 1}"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        StarDisplay(value:
                            scors[index]!=null|| scors[index] != 0 ?
                        scors[index]~/2 :0),

                      ],
                    ),
                  ),
                ),
              );
            })):Center(child: CircularProgressIndicator(),);
  }
}
