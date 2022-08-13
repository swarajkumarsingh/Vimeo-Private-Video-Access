import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class PlayVideoFromNetwork extends StatefulWidget {
  const PlayVideoFromNetwork({Key? key}) : super(key: key);

  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VimeoVideoPlayer(
      vimeoPlayerModel: VimeoPlayerModel(
        url: 'https://player.vimeo.com/video/737153523?h=02b81e6e83',
        deviceOrientation: DeviceOrientation.portraitUp,
        systemUiOverlay: const [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ],
      ),
    ));
  }
}
