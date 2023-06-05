import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_cubit/app_cubit.dart';
import 'app_cubit/app_state.dart';
import 'game_reward.dart';
import 'intro_camera/intro_camera.dart';


class MyApp extends StatelessWidget {
  final Widget startwidget;
  MyApp(this.startwidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..initializeNotification(),
      // providers: [
      //   BlocProvider(
      //     create: (context) => AppCubit()..createDatabase()..initializeNotification(),
      //   ),],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
            ),
            debugShowCheckedModeBanner: false,
            home: startwidget
          );
        },
      ),
    );
  }
}
