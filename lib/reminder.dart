import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../widgets/component.dart';
import 'app_cubit/app_cubit.dart';
import 'app_cubit/app_state.dart';
import 'helper/assets_helper.dart';
import 'helper/cach_helper.dart';
import 'helper/colors.dart';

class reminder extends StatefulWidget {
   reminder({Key? key}) : super(key: key);

  @override
  State<reminder> createState() => _reminderState();
}


class _reminderState extends State<reminder> {

  var box;

  var hour_reminder;
  var minute_reminder;

  var hour_reminder1;
  var minute_reminder1;

  var hour_reminder2;
  var minute_reminder2;

  var hour_reminder3;
  var minute_reminder3;

  @override
  void initState() {
    box=Hive.box('userBox');
    hour_reminder=box.get('hour_reminder');
    minute_reminder=box.get('minute_reminder');
    hour_reminder2=box.get('hour_reminder2');
    minute_reminder2=box.get('minute_reminder2');
    hour_reminder3=box.get('hour_reminder3');
    minute_reminder3=box.get('minute_reminder3');
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: defaultAppBar(CLevelMain, 'Reminder', context),
            body: Column(
              children: [
                InkWell(
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      DateFormat('hh:mm a')
                          .format(DateTime(0, 0, 0, value!.hour, value.minute));
                      setState(() {
                        cubit.hourController = value.hour ?? 9;
                        cubit.minuteController = value.minute ?? 00;

                        box.put('hour_reminder', value.hour ?? 9);
                        box.put('minute_reminder', value.minute ?? 00);
                        hour_reminder =
                            box.get('hour_reminder');
                        minute_reminder =
                            box.get('minute_reminder');
                        cubit.scheduledNotification(
                            hour: value.hour, minutes: value.minute, id: 0);
                        cubit.timeController =
                            '${hour_reminder ?? 9}:${minute_reminder ?? 00}';
                      });
                    });
                  },
                  child: reminderWidget(
                      context: context,
                      title: 'Reminder',
                      subtitle: 'Reminder',
                      color: CLevelMain,
                      time: cubit.timeController??'${hour_reminder ?? 9}:${minute_reminder ?? 00}'),
                  ),


                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        DateFormat('hh:mm a').format(
                            DateTime(0, 0, 0, value!.hour, value.minute));
                        setState(() {

                        cubit.hourController1 = value.hour ?? 9;
                        cubit.minuteController1 = value.minute ?? 00;

                        box.put('hour_reminder1', value.hour ?? 9);
                        box.put('minute_reminder1', value.minute ?? 00);
                        hour_reminder1 =
                            box.get('hour_reminder1');
                        minute_reminder1 =
                            box.get('minute_reminder1');

                        cubit.scheduledNotification(
                            hour: value.hour, minutes: value.minute, id: 1);
                        cubit.timeController1 =
                            '${hour_reminder1 ?? 9}:${minute_reminder1 ?? 00}';
                        });

                      });
                    },
                    child: reminderWidget(
                        context: context,
                        title: 'Reminder',
                        subtitle: 'Reminder',
                        color: CLevelMain,
                        time: cubit.timeController1 ??
                            '${hour_reminder1 ?? 9}:${minute_reminder1 ?? 00}')),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        DateFormat('hh:mm a').format(
                            DateTime(0, 0, 0, value!.hour, value.minute));
                        setState(() {
                        cubit.hourController2 = value.hour ?? 9;
                        cubit.minuteController2 = value.minute ?? 00;

                        box.put('hour_reminder2', value.hour ?? 9);
                        box.put('minute_reminder2', value.minute ?? 00);
                        hour_reminder2 =
                            box.get('hour_reminder2');
                        minute_reminder2 =
                            box.get('minute_reminder2');

                        cubit.scheduledNotification(
                            hour: value.hour, minutes: value.minute, id: 2);
                        cubit.timeController2 =
                            '${hour_reminder2 ?? 9}:${minute_reminder2 ?? 00}';
                        });

                      });
                    },
                    child: reminderWidget(
                        context: context,
                        title: 'Reminder',
                        subtitle: 'Reminder',
                        color: CLevelMain,
                        time: cubit.timeController2 ??
              '${hour_reminder2 ?? 9}:${minute_reminder2 ?? 00}'  )),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      DateFormat('hh:mm a')
                          .format(DateTime(0, 0, 0, value!.hour, value.minute));
                      setState(() {
                      cubit.hourController3 = value.hour ?? 9;
                      cubit.minuteController3 = value.minute ?? 00;

                      box.put('hour_reminder3', value.hour ?? 9);
                      box.put('minute_reminder3', value.minute ?? 00);
                      hour_reminder3 =
                          box.get('hour_reminder3');
                      minute_reminder3 =
                          box.get('minute_reminder3');
                      cubit.scheduledNotification(
                          hour: value.hour, minutes: value.minute, id: 3);
                      cubit.timeController3 =
                          '${hour_reminder3 ?? 9}:${minute_reminder3 ?? 00}';
                      });

                    });
                  },
                  child: reminderWidget(
                      context: context,
                      title: 'Reminder',
                      subtitle: '',
                      color: CLevelMain,
                      time: cubit.timeController3 ??
                          '${hour_reminder3 ?? 9}:${minute_reminder3 ?? 00}'),

                ),
              ],
            ),
          );
        });
  }

  reminderWidget(
      {required BuildContext context,
      required String title,
      required String subtitle,
      required String time,
      required Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: CLevelMain,
                ),
              ),
              SizedBox(
                height: 10,
              ),

            ],
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: CLevelMain,
            ),
          ),
        ],
      ),
    );
  }
}
