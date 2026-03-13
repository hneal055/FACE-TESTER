import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../services/face_detector_service.dart';
import '../widgets/face_overlay_painter.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  File? _image;
  List<Face> _faces = [];
  Size? _imageSize;
  bool _isLoading = false;
  final FaceDetectorService _faceService = FaceDetectorService();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() {
      _isLoading = true;
      _faces = [];
      _imageSize = null;
    });

    final file = File(picked.path);
    final bytes = await file.readAsBytes();
    final decoded = await decodeImageFromList(bytes);
    final faces = await _faceService.detectFromFile(file.path);

    setState(() {
      _image = file;
      _faces = faces;
      _imageSize = Size(decoded.width.toDouble(), decoded.height.toDouble());
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _faceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Image')),
      body: Column(
        children: [
          Expanded(
            child: _image == null
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_search, size: 64, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('Pick an image to detect faces',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(_image!, fit: BoxFit.contain),
                          if (_imageSize != null)
                            CustomPaint(
                              painter: FaceOverlayPainter(
                                faces: _faces,
                                imageSize: _imageSize!,
                                screenSize: MediaQuery.of(context).size,
                                isFrontCamera: false,
                              ),
                            ),
                        ],
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (_faces.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${_faces.length} face(s) detected',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Pick Image'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48)),
                  onPressed: _pickImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
