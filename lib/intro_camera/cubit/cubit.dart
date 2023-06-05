// import 'package:bloc/bloc.dart';
// import 'package:camera/camera.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pediatricfacialrehab/intro_camera/cubit/state.dart';
//
//
// class FaceDetectionCubit extends Cubit<FaceDetectionState> {
//   final FaceDetector _faceDetector;
//   final CameraController _cameraController;
//
//   FaceDetectionCubit(this._faceDetector, this._cameraController) : super(FaceDetectionInitial());
//
//   Future<void> detectFaces() async {
//     emit(FaceDetectionLoading());
//
//     try {
//       final image = await _getImageFromCamera();
//       final faces = await _faceDetector.processImage(image);
//
//       emit(FaceDetectionSuccess(faces));
//     } catch (e) {
//       emit(FaceDetectionFailure(e.toString()));
//     }
//   }
//
//   Future<FirebaseVisionImage> _getImageFromCamera() async {
//     final image = await _cameraController.takePicture();
//     final bytes = await image.readAsBytes();
//     //final size = await _cameraController.getSensorOrientation();
//
//     return FirebaseVisionImage.fromBytes(
//       bytes,
//       FirebaseVisionImageMetadata(
//         size: Size(640, 480),
//         rotation: _getImageRotation(90),
//         rawFormat: ImageFormatGroup.unknown.index,
//       ),
//     );
//   }
//
//   ImageRotation _getImageRotation(int sensorOrientation) {
//     switch (sensorOrientation) {
//       case 90:
//         return ImageRotation.rotation270;
//       case 270:
//         return ImageRotation.rotation90;
//       default:
//         return ImageRotation.rotation0;
//     }
//   }
// }
