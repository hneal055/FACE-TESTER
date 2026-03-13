import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:camera/camera.dart';
import 'dart:ui';

class FaceDetectorService {
  final FaceDetector _detector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableLandmarks: true,
      enableTracking: true,
      performanceMode: FaceDetectorMode.fast,
    ),
  );

  Future<List<Face>> detectFromFile(String path) async {
    final input = InputImage.fromFilePath(path);
    return await _detector.processImage(input);
  }

  Future<List<Face>> detectFromCameraImage(
    CameraImage image,
    CameraDescription camera,
  ) async {
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return [];

    final rotation = _rotationFromSensor(camera.sensorOrientation);
    final metadata = InputImageMetadata(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      format: format,
      bytesPerRow: image.planes.first.bytesPerRow,
    );

    final input = InputImage.fromBytes(
      bytes: image.planes.first.bytes,
      metadata: metadata,
    );
    return await _detector.processImage(input);
  }

  InputImageRotation _rotationFromSensor(int sensorOrientation) {
    switch (sensorOrientation) {
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }

  void dispose() => _detector.close();
}
