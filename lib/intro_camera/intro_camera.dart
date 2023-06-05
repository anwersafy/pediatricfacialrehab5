import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pediatricfacialrehab/helper/assets_helper.dart';
import 'package:pediatricfacialrehab/main.dart';
import 'package:pediatricfacialrehab/main_level.dart';


class cameraIntro extends StatefulWidget {
  @override
  _cameraIntroState createState() => _cameraIntroState();
}

class _cameraIntroState extends State<cameraIntro> {
  late CameraController _controller;
  bool _isInitialized = false;

  var box= Hive.box('photos');

  @override
  void initState() {
    super.initState();
    initializeCamera().then((controller) {
      setState(() {
        _controller = controller;
        _isInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<CameraController> initializeCamera() async {
    final firstCamera = cameras[1];
    final cameraController = CameraController(firstCamera, ResolutionPreset.high);
    await cameraController.initialize();
    return cameraController;
  }

  Future<String> takePicture(CameraController cameraController) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    await cameraController.takePicture().then((value) {
      File(value.path).copy(path);
      box.put('photo', path);


    });
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: _isInitialized
          ? CameraPreview(_controller)
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          takePicture(_controller).then((path) {
            print('Picture saved to $path');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PreviewScreen(imagePath: path,)),
            );
          });
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final String imagePath;

   PreviewScreen({ required this.imagePath}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preview')),
      body: Image.file(File(imagePath)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAndFinish(context: context, widget: levelsScreen());
        },
        child: Icon(Icons.check),
      )
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pediatricfacialrehab/helper/assets_helper.dart';
// import 'package:pediatricfacialrehab/helper/hive_service.dart';
//
// import '../main_level.dart';
// import 'cubit/cubit.dart';
// import 'cubit/state.dart';
//
//
// class CameraPreviewWidget extends StatefulWidget {
//   final CameraDescription camera;
//
//   const CameraPreviewWidget({
//     Key? key,
//     required this.camera,
//   }) : super(key: key);
//
//   @override
//   _CameraPreviewWidgetState createState() => _CameraPreviewWidgetState();
// }
//
// class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
//   late CameraController _controller;
//   Widget? textFace;
//
//
//   final faceDetectionCubit = FaceDetectionCubit(
//       FirebaseVision.instance.faceDetector(FaceDetectorOptions(
//       enableClassification: true,
//       enableLandmarks: true,
//       enableTracking: true,
//     )),
//     CameraController(
//       CameraDescription(
//         name: '0',
//         lensDirection: CameraLensDirection.front,
//         sensorOrientation: 90,
//       ),
//       ResolutionPreset.medium,
//     ),
//   );
//
// // In a widget:
//
//
//
//   @override
//   Widget build(BuildContext context) {
// return BlocProvider(
//   create: (context) => faceDetectionCubit,
//   child: BlocConsumer<FaceDetectionCubit, FaceDetectionState>(
//     listener: (context, state) {
//   if (state is FaceDetectionInitial) {
//   textFace= Text('Press the button to detect faces.');
//   } else if (state is FaceDetectionLoading) {
//   textFace= CircularProgressIndicator();
//   } else if (state is FaceDetectionSuccess) {
//   textFace= Text('${state.faces.length} faces detected!');
//   } else if (state is FaceDetectionFailure) {
//   textFace= Text('Error: ${state.error}');
//   } else {
//   textFace= Container();
//   }
//   },
//     builder: (context, state) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Camera'),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: CameraPreview(_controller),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 faceDetectionCubit.detectFaces();
//                 _controller.takePicture().then((value) {
//                   value.readAsBytes().then((value) {
//                     HiveService().storeImage(value);
//                   });
//
//                 }).then((value) => navigateToAndFinish(context: context, widget: levelsScreen()));
//               },
//               child: textFace??Text('Detect faces'),
//             )
//           ],
//         ),
//       );
//     },
//   ),
// );
//
//   }
//
// }
//
//
//
//
//
//
