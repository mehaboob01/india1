import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';

class CameraScrn extends StatefulWidget {
  const CameraScrn({
    super.key,
  });

  @override
  CameraScrnState createState() => CameraScrnState();
}

class CameraScrnState extends State<CameraScrn> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      profileController.selectedCam,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: Get.height * 0.2,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    Get.back();
                  },
                  child: Center(
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    try {
                      await _initializeControllerFuture;
                      final image = await _controller.takePicture();
                      profileController.image.value = image.path;
                      await profileController.compress().then((value) {
                        profileController.cropImage();
                        Get.back();
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Icon(Icons.camera_alt),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    final cameras = await availableCameras();
                    this.setState(() {
                      profileController.selectedCamInt.value =
                          profileController.selectedCamInt.value == 0 ? 1 : 0;
                      profileController.selectedCam =
                          cameras[profileController.selectedCamInt.value];
                    });

                    this._controller = CameraController(
                      profileController.selectedCam,
                      ResolutionPreset.medium,
                    );

                    this._initializeControllerFuture =
                        this._controller.initialize();
                  },
                  child: const Icon(
                    Icons.cameraswitch,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final mediaSize = MediaQuery.of(context).size;
              return Transform.scale(
                scale:
                    1 / (_controller.value.aspectRatio * mediaSize.aspectRatio),
                child: CameraPreview(
                  _controller,
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(child: CircularProgressIndicator()),
                ],
              );
            }
          },
        ));
  }
}
