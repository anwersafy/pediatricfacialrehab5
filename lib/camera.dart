import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pediatricfacialrehab/game_reward.dart';
import 'package:pediatricfacialrehab/helper/assets_helper.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player/video_player.dart';

import 'Levels_data/level_score_data.dart';
import 'camera_cubit/cubit.dart';
import 'camera_cubit/state.dart';
import 'gallary.dart';
import 'main.dart';

class CameraPage extends StatefulWidget {
  final String video;
  final String levels;
  final String games;
  final String reaction;
  final color;

  CameraPage({
    Key? key,
    required this.video,
    required this.levels,
    required this.games,
    required this.reaction,
    required this.color,
  }) : super(key: key);

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  //final DatabaseAdapter adapter = IsarService();




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraCubit()..

      loadVideoPlayer(widget.video)..
      initCamera(
        widget.reaction,
        context,
        widget.levels,
        widget.games,
      ),
      child: BlocConsumer<CameraCubit,CameraState>(
        listener: (context, state) {

        },

        builder: (context, state) {
          var cubit = CameraCubit.get(context);
          return Screenshot(
            controller: cubit.screenController,
            child: Scaffold(
              backgroundColor: Colors.black,
                appBar: AppBar(
                leading: null,

                  centerTitle: true,
                title: Column(
                  children: [

                    SizedBox(height: 10,),
                    CircularCountDownTimer(
                      duration: 15,
                      initialDuration: 0,
                      controller: CountDownController(),
                      width: 40,
                      height: 40,
                      ringColor: Colors.grey[300]!,
                      ringGradient: null,
                      fillColor: widget.color,
                      fillGradient: null,
                      backgroundColor: Colors.white,
                      backgroundGradient: null,
                      strokeWidth: 20.0,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.S,
                      isReverse: true,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        debugPrint('Countdown Started');
                      },
                      onComplete: () async {
await cubit.onEnd(context,widget.levels,widget.games);
                        // await cubit.captureImage();
                        // levelsData().scoreLevels(widget.levels, widget.games, cubit.count,);
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => GameReward(score: cubit.count)));
                        // //cubit.close();

                      },
                    ),
                  ],
                ),

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

                          color:widget.color
                        ),
                      ),
                    ),
                  ),


                backgroundColor: Colors.transparent
              ),
              body:
              cubit.cameraController != null
                  ? SingleChildScrollView(
                    child: Column(
                children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.25 ,
                            width: MediaQuery.of(context).size.width*0.3,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:

                            cubit. videoController!.value.isInitialized?
                            Chewie(
                              controller: cubit.chewieController!,
                            )
                                : Container(
                              child:Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              //color: CLevel1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Score',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('${cubit.count??'loading'}'
                                    ,style: TextStyle(fontSize: 50,color: widget.color),),
                                  SizedBox(
                                    height: 20,)

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CameraPreview(cubit.cameraController!),
                                    ],
              ),
                  )
                  : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              // body: Column(
              //   children: [
              //     Row(
              //       children: [
              //         Expanded(
              //           child: Container(
              //             height: MediaQuery.of(context).size.height*0.25 ,
              //             width: MediaQuery.of(context).size.width*0.3,
              //             decoration: BoxDecoration(
              //               color: Colors.black,
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child:
              //             cubit. videoController!.value.isInitialized?
              //             Chewie(
              //               controller: cubit.chewieController!,
              //             )
              //                 : Container(
              //               child:Center(child: CircularProgressIndicator()),
              //             ),
              //           ),
              //         ),
              //
              //         Expanded(
              //           child: Container(
              //             padding: EdgeInsets.all(10),
              //             margin: EdgeInsets.all(10),
              //             decoration: BoxDecoration(
              //               //color: CLevel1,
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: SingleChildScrollView(
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     'Score',
              //                     style: TextStyle(fontSize: 20, color: Colors.white),
              //                   ),
              //                   SizedBox(
              //                     height: 20,
              //                   ),
              //                   Text('${cubit.count??'loading'}'
              //                     ,style: TextStyle(fontSize: 50,color: widget.color),),
              //                   SizedBox(
              //                     height: 20,)
              //
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     InputCameraView(
              //       title: 'Face Detection',
              //       onImage:  (image)=> cubit.detectSmiles(
              //           image,
              //           //context,widget.levels,widget.games
              //       ),
              //       resolutionPreset: ResolutionPreset.high,
              //
              //     ),
              //   ],
              // ),
            ),
          );
        }
      ),
    );
  }
}
