import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/data/models/post_model.dart';
import '../controllers/home_controller.dart';

class VideoItem extends StatefulWidget {
  final PostModel post;

  const VideoItem({super.key, required this.post});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> with WidgetsBindingObserver {
  late VideoPlayerController _videoController;
  bool _isInitialized = false;
  bool _isVisible = true;
  bool _isPlaying = true;

  final controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initVideo();
  }

  Future<void> _initVideo() async {
    _videoController = VideoPlayerController.network(widget.post.videoUrl);
    await _videoController.initialize();
    setState(() => _isInitialized = true);
    _videoController.setLooping(true);
    _videoController.play();
    _isPlaying = true;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoController.dispose();
    super.dispose();
  }

  // Pause video when app is inactive
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isInitialized) {
      if (state == AppLifecycleState.paused ||
          state == AppLifecycleState.inactive) {
        _videoController.pause();
        _isPlaying = false;
      } else if (state == AppLifecycleState.resumed && _isVisible) {
        _videoController.play();
        _isPlaying = true;
      }
    }
  }

  void _togglePlayPause() {
    if (_isInitialized) {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
        _isPlaying = false;
      } else {
        _videoController.play();
        _isPlaying = true;
      }
      setState(() {});
    }
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    final visible = info.visibleFraction > 0.7;
    if (visible != _isVisible) {
      _isVisible = visible;
      if (_isInitialized) {
        if (_isVisible) {
          _videoController.play();
          _isPlaying = true;
        } else {
          _videoController.pause();
          _isPlaying = false;
        }
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLiked = widget.post.likedBy.contains(controller.currentUserId);

    return VisibilityDetector(
      key: Key(widget.post.id),
      onVisibilityChanged: _handleVisibilityChanged,
      child: GestureDetector(
        onTap: _togglePlayPause,
        child: Stack(
          children: [
            // Video player
            SizedBox.expand(
              child:
                  _isInitialized
                      ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController.value.size.width,
                          height: _videoController.value.size.height,
                          child: VideoPlayer(_videoController),
                        ),
                      )
                      : Container(
                        color: Colors.black,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
            ),

            // Play icon overlay when paused
            if (_isInitialized && !_isPlaying)
              Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 100,
                  color: Colors.white54,
                ),
              ),

            // Like & Download buttons
            Positioned(
              bottom: 100,
              right: 20,
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.white,
                      size: 32,
                    ),
                    onPressed: () => controller.toggleLike(widget.post),
                  ),
                  const SizedBox(height: 16),
                  IconButton(
                    icon: const Icon(
                      Icons.download,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed:
                        () => controller.downloadVideo(
                          widget.post.videoUrl,
                          "video_${widget.post.id}.mp4",
                        ),
                  ),
                ],
              ),
            ),

            // Title
            Positioned(
              bottom: 30,
              left: 20,
              child: Text(
                widget.post.title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
