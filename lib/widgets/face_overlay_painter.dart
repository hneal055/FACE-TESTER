import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceOverlayPainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;
  final Size screenSize;
  final bool isFrontCamera;

  const FaceOverlayPainter({
    required this.faces,
    required this.imageSize,
    required this.screenSize,
    required this.isFrontCamera,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final boxPaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final scaleX = size.width / imageSize.width;
    final scaleY = size.height / imageSize.height;

    for (final face in faces) {
      final left = isFrontCamera
          ? size.width - face.boundingBox.right * scaleX
          : face.boundingBox.left * scaleX;
      final right = isFrontCamera
          ? size.width - face.boundingBox.left * scaleX
          : face.boundingBox.right * scaleX;

      final rect = Rect.fromLTRB(
        left,
        face.boundingBox.top * scaleY,
        right,
        face.boundingBox.bottom * scaleY,
      );

      canvas.drawRect(rect, boxPaint);

      final label = face.trackingId != null ? 'ID: ${face.trackingId}' : 'Face';
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            color: Colors.greenAccent,
            fontSize: 12,
            backgroundColor: Color(0xAA000000),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(rect.left, rect.top - 18));
    }
  }

  @override
  bool shouldRepaint(FaceOverlayPainter old) => old.faces != faces;
}
