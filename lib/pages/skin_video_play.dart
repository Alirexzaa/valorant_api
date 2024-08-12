import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';

class SkinVideoPage extends StatefulWidget {
  static String routeName = '/SkinVideoPage';
  final String videoUrl;

  const SkinVideoPage({super.key, required this.videoUrl});

  @override
  State<SkinVideoPage> createState() => _SkinVideoPageState();
}

class _SkinVideoPageState extends State<SkinVideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl), // Use Uri.parse to create a URI
    );
    _controller.initialize().then((_) {
      setState(() {});
      _controller.play(); // Start playing the video
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('0f1923'),
      appBar: AppBar(
        backgroundColor: HexColor('0f1923'),
        centerTitle: true,
        title: Text(
          'Skin Videos',
          style: TextStyle(
            color: HexColor('e9404f'),
            fontSize: 32,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: HexColor('e9404f'),
          ),
        ),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('e9404f'),
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          color: HexColor('0f1923'),
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
