import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pediatricfacialrehab/helper/cach_helper.dart';
import 'package:pediatricfacialrehab/splashScreen.dart';


import 'app_cubit/bloc_observe.dart';
import 'camera.dart';

import 'home.dart';
import 'home_screen.dart';
import 'main_level.dart';
import 'package:bloc/bloc.dart';

late var cameras;
 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  Bloc.observer = MyBlocObserver();

  await CachHelper.init();
  var Widget;
  await Hive.initFlutter();
  var userBox = await Hive.openBox('userBox');
  var gameBox= await Hive.openBox('gameBox');
  var photoBox = await Hive.openBox('photos');
  //await FaceCamera.initialize(); //Add this




  var active = userBox.get('active');
  if(active!=null)
  {
    if(active)
    {
      if(DateTime.now().month==6 && DateTime.now().year==2023) {
        Widget = levelsScreen();
      }
      else {
        Widget = Container();
      }
    }

    else
    {
      if(DateTime.now().month==6 && DateTime.now().year==2023) {
        Widget = splashScreen();
      }
      else {
        Widget = Container();
      }

    }
  }
  else
  {
    if(DateTime.now().month==6 && DateTime.now().year==2023) {
      Widget = splashScreen();
    }
    else
    {
      Widget = Container();
    }
  }
  runApp( MyApp(
     Widget,
  ));
}




