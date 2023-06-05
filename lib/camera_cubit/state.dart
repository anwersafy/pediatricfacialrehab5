abstract class CameraState {}

/// The initial state of the camera.
class CameraInitial extends CameraState {}
class CameraLoading extends CameraState {}
class CameraLoaded extends CameraState {}
class CameraError extends CameraState {
  var error;
  CameraError(this.error);
}

class GameEnd extends CameraState {}

class CameraRecognaized extends CameraState {
  var result;
  var count;
  CameraRecognaized({required this.result, required var count});
}
class CameraNotRecognaized extends CameraState {
  var result;
  CameraNotRecognaized({required this.result});
}
class ModelLoaded extends CameraState {}
class ModelLoadError extends CameraState {
  var error;
  ModelLoadError(this.error);
}
class VideoLoading extends CameraState {}
class VideoLoaded extends CameraState {}
class VideoError extends CameraState {
  var error;
  VideoError(this.error);
}
class ModelLoading extends CameraState {}
class ModelRunLoading extends CameraState {}
class ModelRunLoaded extends CameraState {}
class ModelRunError extends CameraState {
  var error;
  ModelRunError(this.error);
}
class ImageStoring extends CameraState {}
class ImageStored extends CameraState {}
class ImageStoreError extends CameraState {
  var error;
  ImageStoreError(this.error);
}

class CameraRecognaizedDone extends CameraState {
  var result;
  var count;
  CameraRecognaizedDone({required this.result,required this.count});
}
class CameraRecognaizedDoneCounting extends CameraState {}
class CameraEnd extends CameraState {}
class MovementDetection extends CameraState {}

class SmileDetected extends CameraState {
  var result;
  SmileDetected(this.result);
}
class CounterRandom extends CameraState{}

class DetectTwoCloseEyes extends CameraState {}
class DetectOneCloseEyes extends CameraState {}
class DetectNoCloseEyes extends CameraState {}
class DetectLeftEyebrowLift extends CameraState {}
class DetectNoLeftEyebrowLift extends CameraState {}
class DetectAddictedEyebrow extends CameraState {}
class DetectNoAddictedEyebrow extends CameraState {}
class DetectBlown extends CameraState {}
class DetectKiss extends CameraState {}
class DetectNoBlown extends CameraState {}
class DetectBigSmile extends CameraState {}
class DetectSmileWithTeeth extends CameraState {}
class DetectSmile extends CameraState {}
class DetectNoSmile extends CameraState {}