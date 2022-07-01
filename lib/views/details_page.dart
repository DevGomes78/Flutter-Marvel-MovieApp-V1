import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../data/models/marvel_models.dart';

class DetailsPage extends StatefulWidget {
  Data data;

  DetailsPage({required this.data});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer() {
    controller =
        VideoPlayerController.network(widget.data.trailerUrl.toString());
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              const SizedBox(height: 30),
              SizedBox(
                  height: 250, child: Text(widget.data.overview.toString())),
              Container(
                height: 200,
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),
              Text("Total Duration: ${controller.value.duration}"),
              VideoProgressIndicator(controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    backgroundColor: Colors.redAccent,
                    playedColor: Colors.green,
                    bufferedColor: Colors.purple,
                  )),
              Container(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if (controller.value.isPlaying) {
                            controller.pause();
                          } else {
                            controller.play();
                          }

                          setState(() {});
                        },
                        icon: Icon(controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow)),
                    IconButton(
                        onPressed: () {
                          controller.seekTo(Duration(seconds: 0));

                          setState(() {});
                        },
                        icon: Icon(Icons.stop))
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
