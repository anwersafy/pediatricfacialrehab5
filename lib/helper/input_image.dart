
import 'package:google_ml_kit/google_ml_kit.dart';

class InputImageFormatMethods {
  static InputImageFormat? fromRawValue(int? rawValue) {
    switch (rawValue) {
      case 35:
        return InputImageFormat.yuv420;
      case 17:
        return InputImageFormat.yuv420;
      case 842094169:
        return InputImageFormat.yuv420;
      default:
        throw Exception('Unknown InputImageFormat value: $rawValue');
    }
  }
}

class InputImageRotationMethods {
  static InputImageRotation? fromRawValue(int? rawValue) {
    switch (rawValue) {
      case 0:
        return InputImageRotation.rotation0deg;
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return null;
    }
  }
}