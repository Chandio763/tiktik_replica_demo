import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../core/data/models/post_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxList<PostModel> posts = <PostModel>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() {
    _firestore.collection('posts').orderBy('title').snapshots().listen((snapshot) {
      posts.value = snapshot.docs
          .map((doc) => PostModel.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  String get currentUserId => _auth.currentUser?.uid ?? '';

  Future<void> toggleLike(PostModel post) async {
    final isLiked = post.likedBy.contains(currentUserId);
    final newLikes = isLiked
        ? FieldValue.arrayRemove([currentUserId])
        : FieldValue.arrayUnion([currentUserId]);

    await _firestore.collection('posts').doc(post.id).update({
      'likedBy': newLikes,
    });
  }

  Future<void> downloadVideo(String url, String filename) async {
    final dio = Dio();
    try {
      final response = await dio.download(url, '/storage/emulated/0/Download/$filename');
      Get.snackbar("Download Complete", "Saved as $filename");
    } catch (e) {
      Get.snackbar("Error", "Failed to download video");
    }
  }
}
