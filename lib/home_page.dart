import 'package:flutter/material.dart';
import 'package:vimeo_demo/video_player_pod.dart';
import 'package:vimeo_demo/video_player_pod_private.dart';
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
        body:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text("Vimeo Demo App"),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                      "NOTE: The given videos are public, \n for private we need to do \n http GET POST request, which will do it tomorrow."),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return const VideoPlayerVimeo();
                      }),
                    );
                  },
                  child: const Text("Vimeo Player"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) {
                    //     return const PlayVideoFromVimeo();
                    //   }),
                    // );
                  },
                  child: const Text("POD Player"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) {
                    //     return  PlayVideoFromNetwork();
                    //   }),
                    // );
                  },
                  child: const Text("Private video vimeo_video_player"),
                ),

              ],
            ),
           );
  }
}

