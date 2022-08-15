// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class pVideo extends StatefulWidget {
  final String appBarText;
  final String videoUrl;
  const pVideo({Key? key, required this.appBarText, required this.videoUrl})
      : super(key: key);

  @override
  State<pVideo> createState() => _pVideoState();
}

class _pVideoState extends State<pVideo> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(
        widget.videoUrl,
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarText.isEmpty ? "Loading" : widget.appBarText),
      ),
      body: PodVideoPlayer(controller: controller),
    );
  }
}
