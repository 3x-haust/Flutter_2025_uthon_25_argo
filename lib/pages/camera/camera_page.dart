import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uthon_2025_argo/main.dart' as main;
import 'package:uthon_2025_argo/util/style/colors.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _isRecording = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      if (main.cameras.isNotEmpty) {
        cameras = main.cameras;
        _controller = CameraController(
          cameras![0],
          ResolutionPreset.medium,
          enableAudio: true,
        );

        await _controller!.initialize();
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      } else {
        cameras = await availableCameras();
        if (cameras != null && cameras!.isNotEmpty) {
          _controller = CameraController(
            cameras![0],
            ResolutionPreset.medium,
            enableAudio: true,
          );

          await _controller!.initialize();
          if (mounted) {
            setState(() {
              _isInitialized = true;
            });
          }
        }
      }
    } catch (e) {
      print('Error initializing camera: $e');
      if (mounted) {
        setState(() {
          _isInitialized = false;
        });
      }
    }
  }

  Future<void> _startVideoRecording() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        !_isInitialized) {
      print('Camera not initialized');
      return;
    }

    if (_isRecording) {
      try {
        final XFile videoFile = await _controller!.stopVideoRecording();
        if (mounted) {
          setState(() {
            _isRecording = false;
          });
        }

        print('Video saved: ${videoFile.path}');

        if (mounted) {
          Get.toNamed('/upload', arguments: videoFile.path);
        }
      } catch (e) {
        print('Error stopping video recording: $e');
        if (mounted) {
          setState(() {
            _isRecording = false;
          });
        }
      }
    } else {
      try {
        await _controller!.startVideoRecording();
        if (mounted) {
          setState(() {
            _isRecording = true;
          });
        }
      } catch (e) {
        print('Error starting video recording: $e');
      }
    }
  }

  void _switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;

    try {
      final currentCameraIndex = cameras!.indexOf(_controller!.description);
      final newCameraIndex = (currentCameraIndex + 1) % cameras!.length;

      final oldController = _controller;
      await oldController?.dispose();
      
      if (mounted) {
        setState(() {
          _isInitialized = false;
          _controller = null;
        });
      }

      await Future.delayed(const Duration(milliseconds: 100));
      
      _controller = CameraController(
        cameras![newCameraIndex],
        ResolutionPreset.medium,
        enableAudio: true,
      );

      await _controller!.initialize();
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('Error switching camera: $e');
      if (mounted) {
        _initializeCamera();
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.white,
      appBar: AppBar(
        backgroundColor: colors.white,
        title: Text(
          '릴 촬영',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 40,
              height: 40,
            ),
            GestureDetector(
              onTap: _startVideoRecording,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _isRecording ? Colors.red : Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: _switchCamera,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.flip_camera_ios,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          if (_isInitialized &&
              _controller != null &&
              _controller!.value.isInitialized)
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: CameraPreview(_controller!),
              ),
            )
          else
            Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
