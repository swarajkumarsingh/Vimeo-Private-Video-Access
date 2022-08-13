import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class VideoPlayerVimeo extends StatefulWidget {
  const VideoPlayerVimeo({Key? key}) : super(key: key);

  @override
  State<VideoPlayerVimeo> createState() => _VideoPlayerVimeoState();
}

class _VideoPlayerVimeoState extends State<VideoPlayerVimeo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vimeo Player"),
      ),
      body: const VimeoPlayer(
        videoId: "737157813",
      ),
    );
  }
}
