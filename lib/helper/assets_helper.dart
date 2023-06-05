import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pediatricfacialrehab/Levels_data/level_score_data.dart';
import 'package:pediatricfacialrehab/helper/path_helper.dart';
import 'package:pediatricfacialrehab/main_level.dart';

import '../camera.dart';
import '../home_screen.dart';
import 'colors.dart';


// List gameLabel=[
//   '0 smile',
//   '1 kiss',
//   '2 Blow check',
//   '3 Rais eyebrow',
//   '4 Close eye',
//   '5 Adduct eyebrow',
//   '6 Happy',
//   '7 Angry',
//   '8 Blow check + eye close'
// ];
//
// List gameLabel1=[
//   '0 normal',
//   '1 smile',
//   '2 o',
//   '3 BLOW',
//   '4 angry',
//   '5 surprise',
//   '6 sleep'
//
// ];


List gameLabel2=[

  smile,
  kiss,
  blown,
  raiseEyebrow,
  closeEye,
  addictedEyebrow,



];

List videosV2=[
  'video/E VS.mp4',
  'video/O VS.mp4',
  'video/Blown3.mp4',
  'video/surprice.mp4',

  'video/angry.mp4',
  'video/karmasha6.mp4',
];

List videos=[
  'video/smile.mp4',
  'video/O2.mp4',
  'video/Blown3.mp4',
  'video/surprice.mp4',

  'video/angry.mp4',
  'video/karmasha6.mp4',
];
List imgLevel=[
  'assets/images/asset-1.png',
  'assets/images/asset-2.png',
  'assets/images/asset-3.png',
  'assets/images/asset-4.png',

  'assets/images/angry.png',
  'assets/images/asset-5.png',
];
List levelsLabel=[
  'Level 1',
  'Level 2',
  'Level 3',
  'Level 4',
  'Level 5',
  'Level 6',

];





class StarDisplay extends StatelessWidget {
  final dynamic value;
   StarDisplay({ Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }
}
// RatingBar(
// initialRating: 3,
// minRating: 1,
// direction: Axis.horizontal,
// allowHalfRating: true,
// itemCount: 5,
// itemSize: 20,
// itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
// onRatingUpdate: (rating) {
// print(rating);
// },
// ratingWidget: RatingWidget(
// full: Icon(Icons.star, color: Colors.amber),
// half: Icon(Icons.star_half, color: Colors.amber),
// empty: Icon(Icons.star_border, color: Colors.amber),
// )),


AppBar defaultAppBar(Color color, String label,BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: () {
        navigateToAndFinish(context: context, widget: levelsScreen());
      },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: 120,
    flexibleSpace: Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        clipper:
        WaveClipperOne(reverse: false),
        child:
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: 142,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(0, 20),
              bottomRight: Radius.circular(30),
            ),
            color: color,
          ),
        ),
      ),
    ),

    //backgroundColor: Color.fromRGBO(244, 83, 68, 1),
    title: Text(
      label,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 34,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
  );
}
navigateTo({required BuildContext context, required Widget widget}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder:
              (context) =>
          widget));
}
navigateToAndFinish({required BuildContext context, required Widget widget}) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder:
              (context) =>
          widget));
}
MaterialButton levelsMB(
    BuildContext context, Widget widget, Color color, String label) {
  return MaterialButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width:MediaQuery.of(context).size.width *0.68,
        height: MediaQuery.of(context).size.height *0.077,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          color: color,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ));
}
Widget defaultAlertDialog(BuildContext context) {
  return AlertDialog(
    elevation: 0,
    buttonPadding: EdgeInsets.all(5),
    backgroundColor: Colors.grey[200],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Text(
      'INFO',
      style: TextStyle(fontSize: 22),
    ),
    icon: Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context, 'OK');
        },
        icon: Icon(
          Icons.cancel_outlined,
          size: 40,
        ),
      ),
    ),
    content: Container(
      child: Text(
        '''This app was created by PT6 of the faculty of physiotherapy KFS University group 7, with the assistance of studentsof The Faculty of Artificial Intelligence KFS university, under the supervision of Prof. Dr Fayez Al-Shami''',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    ),
  );
}
AppBar MainAppBar(Color color, String label) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: 120,
    flexibleSpace: Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        clipper:
        WaveClipperOne(reverse: false),
        child:
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: 142,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(0, 20),
              bottomRight: Radius.circular(30),
            ),
            color: color,
          ),
        ),
      ),
    ),

    //backgroundColor: Color.fromRGBO(244, 83, 68, 1),
    title: Text(
      label,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 34,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
  );
}

Widget MBlevel6(
    List rate,
    level

    ) {

  return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Column(
                children: [
                  IconButton(
                    onPressed: () {
                      navigateToAndFinish(context: context, widget: CameraPage(
                        video: videoLevel6[index],
                        reaction: reactionLevel6[index],
                        levels: level,
                        games: dbGames[index],
                        color: CLevel6,

                      ));
                    },
                    icon: CircleAvatar(
                      backgroundColor: CLevel6,
                      radius: 65,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(imgLevel6[index]),
                      ),
                    ),
                    iconSize: 150,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ]),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            StarDisplay(value: rate[index],),

          ],
        );
      }


  );
}
var imgLevel6 = [
  'assets/images/1.png',
  'assets/images/2.png',
  'assets/images/3.png',
];
var videoLevel6 = [
  'video/smile.mp4',
  'video/angry.mp4',
  'video/O2.mp4',
];

var reactionLevel6=[
 smile,
  addictedEyebrow,
  raiseEyebrow,
];