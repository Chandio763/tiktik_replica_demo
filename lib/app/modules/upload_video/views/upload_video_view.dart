import 'package:firebase_demo_app/app/commons/ui_widgets/ui_primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/upload_video_controller.dart';

class UploadVideoView extends GetView<UploadVideoController> {
  const UploadVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    final UploadVideoController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: Text("Upload Video"), centerTitle: true),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Title Field
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  labelText: 'Enter video title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Pick Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UIPrimaryButton(
                    // icon: Icon(Icons.video_library),  //It was designed for asset file and I don't have right now
                    label: "Gallery",
                    onPressed: () => controller.pickVideo(fromCamera: false),
                  ),
                  UIPrimaryButton(
                    // icon: Icon(Icons.videocam), //
                    label: "Camera",
                    onPressed: () => controller.pickVideo(fromCamera: true),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Show picked video path
              controller.pickedVideo.value != null
                  ? Text(
                    "Selected: ${controller.pickedVideo.value!.path.split('/').last}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                  : Text("No video selected"),

              const SizedBox(height: 24),

              // Upload Button
              controller.isUploading.value
                  ? Column(
                    children: [
                      LinearProgressIndicator(
                        value: controller.uploadProgress.value,
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Uploading... ${(controller.uploadProgress.value * 100).toStringAsFixed(0)}%",
                      ),
                    ],
                  )
                  : SizedBox(
                    width: double.infinity,
                    child: UIPrimaryButton(
                      label: "Upload",
                      onPressed: controller.uploadVideoToFirebase,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
