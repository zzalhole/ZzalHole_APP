import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zzal_hole/core/component/config.dart';

class ZzalPlayer extends StatefulWidget {
  const ZzalPlayer({super.key, required this.url, this.isPaused = false});

  final String url;
  final bool isPaused;

  @override
  State<ZzalPlayer> createState() => _ZzalPlayerState();
}

class _ZzalPlayerState extends State<ZzalPlayer> {
  late final VideoPlayerController controller;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(
      Uri.parse('$baseUrl${widget.url}'),
    );
    controller.initialize().then((_) {
      setState(() {});
      if (widget.isPaused) {
        controller.pause();
      } else {
        controller.play();
      }
    });
    controller.addListener(() {
      if (controller.value.position >= controller.value.duration &&
          !controller.value.isPlaying) {
        controller.seekTo(Duration.zero);
        controller.play();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              setState(() {
                if (controller.value.isPlaying) {
                  controller.pause();
                  isPaused = true;
                } else {
                  controller.play();
                  isPaused = false;
                }
              });
            },
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: controller.value.size.width,
                  height: controller.value.size.height,
                  child: VideoPlayer(controller),
                ),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(color: Color(0xff684C48)),
          );
  }
}
