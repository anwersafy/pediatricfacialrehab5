import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pediatricfacialrehab/reminder.dart';
import 'package:pediatricfacialrehab/splashScreen.dart';
import 'package:slider_controller/slider_controller.dart';

import 'Levels_data/level_score_data.dart';
import 'app_cubit/app_cubit.dart';
import 'app_cubit/app_state.dart';
import 'gallary.dart';
import 'helper/assets_helper.dart';
import 'helper/colors.dart';
import 'level.dart';
import 'level6.dart';

class levelsScreen extends StatefulWidget {
  @override
  State<levelsScreen> createState() => _levelsScreenState();
}

class _levelsScreenState extends State<levelsScreen> {
  double values = 0.0;
  //var SliderStream= StreamController();
  String dropdownValue = 'English';
  var colorS;
  var username;
  var password;
  var gameBox = Hive.box('gameBox');
  late var userImg;
  var photoBox = Hive.box('photos');


var levelData=levelsData();
  @override
  initState() {
    var box = Hive.box('userBox');
    username = box.get('username');
    password = box.get('password');
    userImg = photoBox.get('photo');

   //get score from all levels

    // for (int i = 0; i < 6; i++) {
    //   for (int i = 0; i < 6; i++) {
    //     levelData.getScoreLevels(levelsLabel[i], dbGames[i]).then((value) {
    //       setState(() {
    //         if(value!=null)
    //         {
    //           values+=value;
    //         }
    //         else
    //         {
    //           values+=0;
    //         }
    //       });
    //     });
    //   }
    // }

values=gameBox.get('all_Scores')??1/5;


    values = values > 330 ? 330 : values??0;


    colorS = values <60*5 ? CLevel1: values< 120*5 ?CLevel2: values<180*5 ?CLevel3: values<260*5 ?CLevel4: values<330*5 ?CLevel5: CLevel6;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: MainAppBar(
                CLevelMain,
                'Levels',
              ),
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,

                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            levelsMB(
                              context,
                              levelScreen6(
                                label: levelsLabel[5],
                                color: levelColor[5],
                                levels: levelsLabel[5],
                              ),
                              levelColor[5],
                              levelsLabel[5],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            levelsMB(
                              context,
                              levelScreen(
                                label: levelsLabel[4],
                                color: levelColor[4],
                                levels: levelsLabel[4],
                              ),
                              levelColor[4],
                              levelsLabel[4],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            levelsMB(
                              context,
                              levelScreen(
                                label: levelsLabel[3],
                                color: levelColor[3],
                                levels: levelsLabel[3],
                              ),
                              levelColor[3],
                              levelsLabel[3],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            levelsMB(
                              context,
                              levelScreen(
                                label: levelsLabel[2],
                                color: levelColor[2],
                                levels: levelsLabel[2],
                              ),
                              levelColor[2],
                              levelsLabel[2],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            levelsMB(
                              context,
                              levelScreen(
                                label: levelsLabel[1],
                                color: levelColor[1],
                                levels: levelsLabel[1],
                              ),
                              levelColor[1],
                              levelsLabel[1],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            levelsMB(
                              context,
                              levelScreen(
                                label: levelsLabel[0],
                                color: levelColor[0],
                                levels: levelsLabel[0],
                              ),
                              levelColor[0],
                              levelsLabel[0],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.001,
                            ),
                            Container(
                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.0005),
                              alignment: Alignment.centerLeft,
                              width:
                                  MediaQuery.of(context).size.width * 0.0000000001,
                              height: MediaQuery.of(context).size.height * 0.72,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: SliderController(
                                  min: 0,
                                  max: 1500,


                                  isDraggable: true,
                                  sliderDecoration: SliderDecoration(

                                    isThumbVisible: false,
                                    activeColor: colorS,
                                    inactiveColor: Colors.grey.withOpacity(0.5),

                                    //height: MediaQuery.of(context).size.height * 0.75,
                                  ),
                                  value: values,
                                  onChanged: ( value) {

                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              drawer: Container(
                width: 200,
                child: Drawer(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: CLevelMain,
                        ), //BoxDecoration
                        child: UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            color: CLevelMain,
                          ),
                          accountName: Text(
                            "Welcome",
                            style: TextStyle(fontSize: 11),
                          ),
                          accountEmail: Text(
                            username ??
                                AppCubit.get(context).usernameController.text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          currentAccountPictureSize: Size.square(50),
                          currentAccountPicture: CircleAvatar(
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage:userImg!=null?
                              Image.file(File(userImg)).image:
                              AssetImage(

                                  'assets/images/Profile Image-1.png'),
                            ),
                          ), //circleAvatar
                        ), //UserAccountDrawerHeader
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/images/gallery.png'),
                        ),
                        title: const Text('Gallery '),
                        onTap: () {
                          var passwordControllerG = TextEditingController();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlertDialog(
                                  backgroundColor:
                                      Color.fromRGBO(230, 230, 230, 1),
                                  icon: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      icon: Icon(Icons.close)),
                                  title: Column(
                                    children: [
                                      Center(
                                          child: Text(
                                        'Please enter your password',
                                        style: TextStyle(fontSize: 16),
                                      )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: passwordControllerG,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              hintText: 'Password'),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Roboto'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      MaterialButton(
                                          onPressed: () {
                                            if (passwordControllerG.text ==
                                                password) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Gallary()));
                                            } else {
                                              Navigator.pop(context, 'OK');
                                            }
                                          },
                                          child: Container(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            width: 150.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Container(
                                              color: Colors.white,
                                              child: Center(
                                                child: Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                      ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/images/Reminder.png'),
                        ),
                        title: const Text(' Reminder '),
                        onTap: () {
                          var passwordControllerR = TextEditingController();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlertDialog(
                                  backgroundColor:
                                      Color.fromRGBO(230, 230, 230, 1),
                                  icon: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      icon: Icon(Icons.close)),
                                  title: Column(
                                    children: [
                                      Center(
                                          child: Text(
                                        'Please enter your password',
                                        style: TextStyle(fontSize: 16),
                                      )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: passwordControllerR,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              hintText: 'Password'),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Roboto'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      MaterialButton(
                                          onPressed: () {
                                            if (passwordControllerR.text ==
                                                password) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          reminder()));
                                            } else {
                                              Navigator.pop(context, 'OK');
                                            }
                                          },
                                          child: Container(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            width: 150.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Container(
                                              color: Colors.white,
                                              child: Center(
                                                child: Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                      ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/images/language.png'),
                        ),
                        title: DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['English', 'Arabic']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                              'assets/images/noun_Info_1174604.png'),
                        ),
                        title: const Text(' INFO '),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    defaultAlertDialog(context),
                              ));
                        },
                      ),
                      ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/images/share.png'),
                        ),
                        title: const Text('Share'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 210,
                      ),
                      ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                              'assets/images/Screenshot 2023-01-10 095030.png'),
                        ),
                        title: const Text('Logout'),
                        onTap: () {
                         AppCubit.get(context).logout();

                          navigateToAndFinish(
                              context: context, widget: splashScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

