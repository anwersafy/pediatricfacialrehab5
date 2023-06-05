import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:pediatricfacialrehab/helper/colors.dart';
import 'package:rxdart/rxdart.dart';

import '../Levels_data/level_score_data.dart';
import '../main_level.dart';
import 'app_state.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(LoginInitial());

  static AppCubit get(context) => BlocProvider.of(context);


  var usernameController = TextEditingController();
  var passwordController = TextEditingController();





  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  var playerName;
  var playerPassword;
  var active;


var userBox=Hive.box('userBox');
var gameBox=Hive.box('gameBox');
var photoBox=Hive.box('photos');

  void login({required String username, required String password}) async {
    emit(LoginLoadingState());
    userBox = await Hive.openBox('userBox');
    userBox.put('username', username);
    userBox.put('password', password);
    userBox.put('active', true);
    emit(LoginSuccessState());
  }

  void logout() async{

    Hive.openBox('screenShotBox').then((value) => value.clear());


    userBox.put('active', false);
   userBox.put('username', '');
    userBox.put('password', '');


    gameBox.clear();
    photoBox.clear();

    usernameController.clear();
    passwordController.clear();

    emit(LoginInitial());
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initialize notification
  initializeNotification() async {
    _configureLocalTimeZone();
    // const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/launcher_icon');
     var initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {

      }
    );

     InitializationSettings initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,

    );
    emit(InitializeNotificationState());

  }

  /// Set right date and time for notifications
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    emit(SetTimeNotificationState());

    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  /// Scheduled Notification
  scheduledNotification({
    required int hour,
    required int minutes,
    required int id,
    //required String sound,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'It\'s time to play !',
      'Play the game and have fun',
      _convertTime(hour, minutes),
      NotificationDetails(
        android: AndroidNotificationDetails(
          //'your channel id $sound',
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          //sound: RawResourceAndroidNotificationSound(sound),
        ),
        //iOS: IOSNotificationDetails(sound: '$sound.mp3'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'It could be anything you pass',
    );
    emit(ScheduledNotificationState());
  }

  /// Request IOS permissions
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    emit(RequestIOSPermissionState());
  }

  cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    emit(CancelAllNotificationState());
  }
  cancel(id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    emit(CancelNotificationState());
  }



var timeController;
var hourController;
var minuteController ;
var hour_reminder;
var minute_reminder;

var timeController1;
var hourController1;
var minuteController1 ;
var hour_reminder1;
var minute_reminder1;

var timeController2;
var hourController2;
var minuteController2 ;
var hour_reminder2;
var minute_reminder2;

var timeController3;
var hourController3;
var minuteController3 ;
var hour_reminder3;
var minute_reminder3;

var timeController4;
var hourController4;
var minuteController4 ;
var hour_reminder4;
var minute_reminder4;



  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    emit(OnSelectNotificationState());
    return Future.value(0);
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse,BuildContext context) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => levelsScreen()),
    );
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  var scoreS=0.0;
  var colorS=Colors.white;

  sliderInit()async{
    emit(SliderInitState());
    sliderScore().then((value){
      scoreS = value;
      emit(SliderChangeState());
    });
    sliderColor(
      scoreS
    ).then((value){
      colorS = value;
      emit(SliderChangeState());
    });
    emit(SliderChangeEndState());
    }
    sliderChange(double value)async{
    emit(SliderChangeState());
    sliderScore().then((value){
      scoreS = value;
      emit(SliderChangeState());
    });
    sliderColor(
      scoreS
    ).then((value){
      colorS = value;
      emit(SliderChangeState());
    });
    emit(SliderChangeEndState());
    }


  }



