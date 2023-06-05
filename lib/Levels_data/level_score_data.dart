import 'package:hive/hive.dart';
import 'package:pediatricfacialrehab/helper/colors.dart';

var level1;
var level2;
var level3;
var level4;
var level5;
var level6;
var all_Scores ;
var colorLevel;
class levelsData {
  scoreLevels(levelNumber, gameNumber, Score) async {
    var gameBox=await Hive.openBox('gameBox');
    levelNumber = await Hive.openBox('${levelNumber.toString()}');
    levelNumber.put('${gameNumber.toString()}', Score);

    all_Scores = await gameBox.get('all_Scores')??0.0;
    //max =100.0; min=0.0;

    all_Scores += Score;
    gameBox.put('all_Scores', all_Scores);

    //colorLevel= await gameBox.get('colorLevel')??CLevel1;
    colorLevel = await sliderColor(all_Scores);
    gameBox.put('colorLevel', colorLevel);




  }

  getScoreLevels(levelNumber, gameNumber) async {
    levelNumber = await Hive.openBox('${levelNumber.toString()}');
    var score = levelNumber.get('${gameNumber.toString()}');
    return score;
  }


}
var dbLevels=[level1,level2,level3,level4,level5,level6];
var dbGames=['game1','game2','game3','game4','game5','game6'];


sliderScore() async {
  var score = 0.0;
  for (var i = 0; i < 6; i++) {
    for (var j = 0; j < 6; j++) {
      double? score1 = await levelsData().getScoreLevels(dbLevels[i], dbGames[j]);
      if (score1 != null) {
        score += score1;
      }
      else{
        score+=0.0;
      }
    }
  }

  return score;
}

allScore()async{
  var box = await Hive.openBox('gameBox');
  var score = box.get('all_Scores');
  return score;
}
sliderColor( score ) async {
  //var score = await sliderScore();


  if (score >= 0.0 && score <= 60.0) {
    return CLevel1;
  } else if (score >= 61.0 && score <= 120.0) {
    return CLevel2;
  } else if (score >= 121.0 && score <= 180.0) {
    return CLevel3;
  } else if (score >= 181.0 && score <= 240.0) {
    return CLevel4;
  } else if (score >= 241.0 && score <= 300.0) {
    return CLevel5;
  } else if (score >= 301.0 && score <= 360.0) {
    return CLevel6;
  } else {
    return CLevel1;
  }
}