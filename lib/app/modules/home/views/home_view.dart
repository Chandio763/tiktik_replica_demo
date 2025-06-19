import 'package:firebase_demo_app/app/core/utils/app_colors.dart';
import 'package:firebase_demo_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'video_item_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.UPLOAD_VIDEO);
        },
        child: Icon(Icons.add),
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text("Tiktok"),
      //   centerTitle: true,
      // ),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500),
        child: Obx(
          () =>
              controller.posts.isEmpty
                  ? Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                  : PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      final post = controller.posts[index];
                      return VideoItem(post: post);
                    },
                  ),
        ),
      ),
    );
  }
}
