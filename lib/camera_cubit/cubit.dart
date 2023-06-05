import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pediatricfacialrehab/helper/assets_helper.dart';
import 'package:pediatricfacialrehab/helper/path_helper.dart';
import 'package:pediatricfacialrehab/main_level.dart';
import 'package:screenshot/screenshot.dart';

import 'package:video_player/video_player.dart';

import '../Levels_data/level_score_data.dart';
import '../camera.dart';

import '../game_reward.dart';
import '../helper/input_image.dart';
import '../main.dart';
import 'state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());

  static CameraCubit get(context) => BlocProvider.of(context);

  late var cameraController;
  var screenController = ScreenshotController();

  // String get videos => widget.video;
  //
  CameraImage? cameraImage;

  var result;
  late VideoPlayerController? videoController;
  var chewieController;

  loadVideoPlayer(video) {
    videoController = VideoPlayerController.asset(video);
    videoController!.initialize().then((value) {

      chewieController = ChewieController(
        videoPlayerController: videoController!,

        showControls: false,
        showControlsOnInitialize: false,
        showOptions: false,
        autoPlay: true,
        looping: true,

      );
      if (count == 50) {
        videoController!.dispose();
        videoController = null;
        chewieController.dispose();
        chewieController = null;
      }
      emit(VideoLoaded());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(VideoError(error.toString()));
    });
  }

  var confidence;

  initCamera(String reaction, BuildContext context, String levels,
      String games) async {
    emit(CameraLoading());
    cameraController = CameraController(
      cameras[1],
      ResolutionPreset.medium,
    );
    cameraController.initialize().then((value) {
      cameraController.startImageStream((CameraImage image) {
        if (cameraController.value.isStreamingImages) {
          cameraImage = image;
          CameraDescription camera = cameraController!.description;


          final WriteBuffer allBytes = WriteBuffer();
          for (Plane plane in cameraImage!.planes) {
            allBytes.putUint8List(plane.bytes);
          }
          final bytes = allBytes.done().buffer.asUint8List();

          final Size imageSize =
          Size(cameraImage!.width.toDouble(), cameraImage!.height.toDouble());

          final InputImageRotation imageRotation =
              InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
                  InputImageRotation.rotation0deg;

          final InputImageFormat inputImageFormat =
              InputImageFormatMethods.fromRawValue(cameraImage?.format.raw) ??
                  InputImageFormat.nv21;

          final planeData = cameraImage?.planes.map(
                (Plane plane) {
              return InputImagePlaneMetadata(
                bytesPerRow: plane.bytesPerRow,
                height: plane.height,
                width: plane.width,
              );
            },
          ).toList();

          final inputImageData = InputImageData(
            size: imageSize,
            imageRotation: imageRotation,
            inputImageFormat: inputImageFormat,
            planeData: planeData,
          );

          final inputImage = InputImage.fromBytes(
            bytes: bytes,
            inputImageData: inputImageData,
          );

          processImage(inputImage,
            reaction,
            context,
            levels,
            games,
          );

          emit(CameraLoaded());
        } else {
          emit(CameraError('Camera is not streaming'));
        }
      });
    }).catchError((error) {
      debugPrint(error);
      emit(CameraError(error.toString()));
    });
  }




  int count = 0;

  int previousCount = 0;
  Timer? countTimer;

  Timer? timer;


   stopcount() {
  timer?.cancel();
  }





  FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      enableClassification: true,
      enableTracking: true,
    ),
  );





  var label;


  processImage(inputImage
      , reaction, context, levels, games
      ) async {
   if(count!=50) {
      faceDetector.processImage(inputImage).then((value) {
        var faces = value;
        if (faces.isEmpty) {
          label = 'No face';
        }
        else {
          var face = faces.first;

          if (reaction == 'Smile') {
            label = detectSmile(face);
          }
          else if (reaction == 'Kiss' || reaction == 'Blown') {
            label = detectBlown(face);
          }
          else if (reaction == 'Rais Eyebrow') {
            label = detectLeftEyebrow(face);
          }
          else if (reaction == 'Addicted Eyebrow') {
            label = detectAddictedEyebrow(face);
          }
          else if (reaction == 'Close Eyes') {
            label = detectCloseEyes(face);
          }
        }
      });
    }

  }

  detectSmile(Face face) {

    if (face.smilingProbability! > 0.86) {

      if(count != 50){
        count++;
      }


      emit(DetectBigSmile());
      // return 'Big smile with teeth';
    } else if (face.smilingProbability!> 0.8) {

      emit(DetectSmileWithTeeth());
      //  return 'Big Smile';
    } else if (face.smilingProbability! > 0.3) {
      // countEvey1sec();
      emit(DetectSmile());
      // return 'Smile';
    } else {
      emit(DetectNoSmile());
      //   return 'Sad';
    }

  }
  String detectBlown(Face face) {

    if (face.smilingProbability! > 0.0040 && face.smilingProbability! < 0.0099) {

      if(count != 50){
        count++;
      }

      emit(DetectBlown());
      return 'blow';
    } else if (face.smilingProbability! > 0.0090 && face.smilingProbability! < 0.0150) {
      emit(DetectKiss());
      return 'kiss';

    } else {
      emit(DetectNoBlown());
      return 'Sad';
    }
  }

  String detectCloseEyes(Face face) {
    if(face.leftEyeOpenProbability! < 0.01 || face.rightEyeOpenProbability! < 0.01){
      if(count != 50){
        count++;
      }

      emit(DetectTwoCloseEyes());
      return 'Close eyes';
    }else {
      emit(DetectNoCloseEyes());
      return 'Normal';
    }
  }

  String detectLeftEyebrow(face) {
    if (face.contours[FaceContourType.leftEye]!.points[face.contours[FaceContourType.leftEye]!.points.length~/2].distanceTo(face.contours[FaceContourType.leftEyebrowBottom]!.points[face.contours[FaceContourType.leftEyebrowBottom]!.points.length~/2]) >65||
        face.contours[FaceContourType.rightEye]!.points[face.contours[FaceContourType.rightEye]!.points.length~/2].distanceTo(face.contours[FaceContourType.rightEyebrowBottom]!.points[face.contours[FaceContourType.rightEyebrowBottom]!.points.length~/2]) >65
    ){
      if(count != 50){
        count++;
      }

      emit(DetectLeftEyebrowLift());
      return 'Eyebrow lift';
    }
    else{
      emit(DetectNoLeftEyebrowLift());
      return  'normal';
    }
  }
  String detectAddictedEyebrow(face){
    if (face.contours[FaceContourType.leftEye]!.points[face.contours[FaceContourType.leftEye]!.points.length~/2].distanceTo(face.contours[FaceContourType.leftEyebrowBottom]!.points[face.contours[FaceContourType.leftEyebrowBottom]!.points.length~/2]) <40||
        face.contours[FaceContourType.rightEye]!.points[face.contours[FaceContourType.rightEye]!.points.length~/2].distanceTo(face.contours[FaceContourType.rightEyebrowBottom]!.points[face.contours[FaceContourType.rightEyebrowBottom]!.points.length~/2]) <40
    ){
      if(count != 50){
        count++;
      }

      emit(DetectAddictedEyebrow());
      return 'Eyebrow down';
    }
    else{
      emit(DetectNoAddictedEyebrow());
      return  'Normal';
    }
  }



  //int countReact=Rcounter;

  // detectSmiles(inputImage,
  //     reaction, context, levels, games) async {
  //   var faces = await faceDetector.detect(inputImage);
  //
  //   // bool isSmiling = false;
  //
  //   for (Face face in faces) {
  //     if (face.smilingProbability != null) {
  //       if (face.smilingProbability! > 0.8) {
  //         if (count != 10) {
  //           count++;
  //
  //           emit(CameraRecognaized(
  //             result: reaction,
  //             count: count,
  //           ));
  //         } else {
  //           count = 10;
  //           //onEnd(context, levels, games);
  //           emit(CameraRecognaizedDone(
  //             result: reaction,
  //             count: count,
  //           ));
  //         }
  //       }
  //     }
  //     emit(MovementDetection());
  //   }
  // }

StorageScreenShot(
    String pathImage
    )async{
  var box = await Hive.openBox('screenShotBox');
  List<dynamic>? pathImages = box.get('images');
  if (pathImages == null) {
    pathImages = [];
  }
  pathImages.add(pathImage);
  box.put('images', pathImages);
  emit(ImageStored());



}

  captureImage() async {
    emit(ImageStoring());
     final directory = await getApplicationDocumentsDirectory();


await screenController.captureAndSave(directory.path).then((value) async {
      await StorageScreenShot(value!);

      emit(ImageStored());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(ImageStoreError(onError.toString()));
});

    // await screenController.capture().then((Uint8List? image) async {
    //
    //   await adapter.storeImage(image!).then((value) => emit(ImageStored()));
    // }).catchError((onError) {
    //   debugPrint(onError.toString());
    //   emit(ImageStoreError(onError.toString()));
    // });
  }

  onEnd(BuildContext context, String levels, String games) async {
    await captureImage();

    await levelsData()
        .scoreLevels(
      levels,
      games,
      count,
    )
        .then((value) async {



      if (cameraController != null) {
        await cameraController
            .stopImageStream()
            .then((value) => cameraController.dispose());
      }
      if (videoController != null) {
        videoController!.dispose();
        chewieController.dispose();
        videoController = null;
        chewieController = null;
      }

      await faceDetector.close();
      navigateToAndFinish(context: context, widget: GameReward(score: count));

      cameraController.stopImageStream();
      if (videoController != null) {
        videoController!.dispose();
        chewieController.dispose();
        videoController = null;

        chewieController = null;
      }
      cameraController.dispose();

      // close();
    });
    emit(CameraEnd());
  }

  @override
  Future<void> close() async {
    await faceDetector.close();

    // await cameraController
    //     .stopImageStream()
    //     .then((value) => cameraController.dispose());
    if (cameraController != null) {
      await cameraController
          .stopImageStream()
          .then((value) => cameraController.dispose());
    }

    if (videoController != null) {
      videoController!.dispose();
      chewieController.dispose();
      chewieController = null;
      videoController = null;
    }


    return super.close();
  }
}


//      if (face.smilingProbability != null && face.smilingProbability! > 0.5) {
//         //isSmiling = true;
//         smileCount++;
//
//         _smileStreamController.add(SmileDetected(isSmiling));
//
//         if (smileCount == 1) {
//           Timer.periodic(Duration(seconds: 1), (timer) {
//             // Check for smile in the faces collection
//             for (Face face in faces) {
//
//               if (face.smilingProbability != null &&
//                   face.smilingProbability! > 0.7) {
//                 smileCount++;
//                 _startSmileTimer();
//
//
//                 _smileStreamController.add(SmileDetected(isSmiling));
//                 if (smileCount == 1) {
//
//                   _smileStreamController.add(SmileDetected(isSmiling));
//                   emit(SmileDetected(isSmiling));
//
//                 }
//                 emit(SmileDetected(isSmiling));
//                 break;
//               }
//             }
//           });
//         }
//
//         emit(SmileDetected(isSmiling));
//
//         break;
//       }