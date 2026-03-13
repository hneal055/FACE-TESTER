import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'review_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Tester'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.face, size: 80, color: Colors.blue),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Live Camera Detection'),
              style: ElevatedButton.styleFrom(minimumSize: const Size(240, 50)),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CameraScreen()),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text('Review from Gallery'),
              style: ElevatedButton.styleFrom(minimumSize: const Size(240, 50)),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReviewScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
