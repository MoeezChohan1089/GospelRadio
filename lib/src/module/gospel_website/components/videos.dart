import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:video_player/video_player.dart';

import '../../contact/view.dart';

class Video {
  final String url;

  Video(this.url);
}

List<Video> videos = [
  Video('https://hgcradio.org/storage/app/public/ads/scroll_pages.mp4'),
  Video('https://hgcradio.org/storage/app/public/ads/hg.mp4'),
  Video('https://hgcradio.org/storage/app/public/ads/singalong.mp4'),
  Video('https://hgcradio.org/storage/app/public/ads/pipeline.mp4')
];

class HorizontalVideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return Wrap(
          children: [
            VideoCard(video: videos[index]),
          ],
        );
      },
    );
  }
}

class VideoCard extends StatefulWidget {
  final Video video;

  VideoCard({required this.video});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  _initializeVideoPlayer() async {
    _controller = VideoPlayerController.network(widget.video.url);

    /// Initialize the video player
    await _controller.initialize();
    _controller.play();

    /// The rest of your code
    // final chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   autoPlay: true,
    //   looping: true,
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.heightBox,
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: GestureDetector(
            onTap: () {
              Get.to(() => ContactPage());
            },
            child: Container(
              height: 100,
              width: 160,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List<Video> videos11 = [
  Video(
      'https://hgcradio.org/storage/app/public/ads/your_ad_here_redone_1.mp4'),
  Video(
      'https://hgcradio.org/storage/app/public/ads/your_ad_here_redone_2.mp4'),
  Video('https://hgcradio.org/storage/app/public/ads/your_ad_here_redone_3.mp4')
];

class HorizontalVideoList1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: videos11.length,
      itemBuilder: (context, index) {
        return Wrap(
          children: [
            VideoCard1(video1: videos11[index]),
          ],
        );
      },
    );
  }
}

class VideoCard1 extends StatefulWidget {
  final Video video1;

  VideoCard1({required this.video1});

  @override
  _VideoCard1State createState() => _VideoCard1State();
}

class _VideoCard1State extends State<VideoCard1> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    // _controller = VideoPlayerController.network(widget.video1.url)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown
    //     setState(() {});
    //   });
  }

  _initializeVideoPlayer() async {
    _controller = VideoPlayerController.network(widget.video1.url);

    /// Initialize the video player
    await _controller.initialize();
    _controller.play();

    /// The rest of your code
    // final chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   autoPlay: true,
    //   looping: true,
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.heightBox,
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: GestureDetector(
            onTap: () {
              Get.to(() => ContactPage());
            },
            child: Container(
              height: 100,
              width: 170,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
