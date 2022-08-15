import 'package:flutter/material.dart';
import 'package:vimeo_demo/video_player_vimeo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vimeo Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          //**
          // Below Widget is for something
          // */
          One(),
          //**
          // Below Widget is for something
          // */
          Two(),
          //**
          // Below Widget is for something
          // */
          Three(),
        ],
      ),
    );
  }
}

class Three extends StatelessWidget {
  const Three({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (_) {
        //     return  PlayVideoFromNetwork();
        //   }),
        // );
      },
      child: const Text("Private video vimeo_video_player"),
    );
  }
}

class Two extends StatelessWidget {
  const Two({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (_) {
        //     return const PlayVideoFromVimeo();
        //   }),
        // );
      },
      child: const Text("POD Player"),
    );
  }
}

class One extends StatelessWidget {
  const One({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return const VideoPlayerVimeo();
          }),
        );
      },
      child: const Text("Vimeo Player"),
    );
  }
}
