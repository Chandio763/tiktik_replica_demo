import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

class UploadVideoController extends GetxController {
  Rx<File?> pickedVideo = Rx<File?>(null);
  RxDouble uploadProgress = 0.0.obs;
  RxBool isUploading = false.obs;

  final TextEditingController titleController = TextEditingController();

  Future<void> pickVideo({bool fromCamera = false}) async {
    final picker = ImagePicker();
    final picked = await picker.pickVideo(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    if (picked != null) {
      pickedVideo.value = File(picked.path);
    }
  }

  Future<void> uploadVideoToFirebase() async {
    final file = pickedVideo.value;
    final title = titleController.text.trim();
    if (file == null || title.isEmpty) {
      Get.snackbar("Error", "Please pick a video and enter title");
      return;
    }

    isUploading.value = true;
    final fileName = basename(file.path);
    final storageRef = FirebaseStorage.instance.ref().child('videos/$fileName');

    final uploadTask = storageRef.putFile(file);

    uploadTask.snapshotEvents.listen((event) {
      uploadProgress.value = event.bytesTransferred / event.totalBytes;
    });

    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('posts').add({
      'title': title,
      'videoUrl': downloadUrl,
      'likedBy': [],
    });

    isUploading.value = false;
    pickedVideo.value = null;
    titleController.clear();
    Get.snackbar("Success", "Video uploaded successfully!");
  }
}
