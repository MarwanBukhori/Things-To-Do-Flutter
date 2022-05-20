import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final controller = CameraController(cameras[0], ResolutionPreset.high);

  @override
  void initState() {
    super.initState();
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SafeArea(
              child: CameraPreview(controller),
            ),
          ),
          Container(
            color: Colors.black87,
            height: 80,
            child: Center(
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      splashColor: Colors.white38,
                      highlightColor: Colors.white24,
                      color: Colors.white,
                      icon: Icon(Icons.camera_alt),
                      onPressed: () async {
                        try {
                          XFile xfile = await controller.takePicture();

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                      'Image has been saved at ${xfile.path}'),
                                );
                              });
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(e.toString()),
                              );
                            },
                          );
                        }
                      },
                      iconSize: 32,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}