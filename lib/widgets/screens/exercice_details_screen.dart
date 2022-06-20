import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class ExerciceDetailsScreen extends StatefulWidget {
  // static const routeName = '/exercice-details';
  final String? youtubeLink;
  final String? title;
  final String? description;
  final String? details;

  ExerciceDetailsScreen({
    required this.youtubeLink,
    required this.title,
    required this.description,
    required this.details,
  });

  @override
  State<ExerciceDetailsScreen> createState() => _ExerciceDetailsState();
}

class _ExerciceDetailsState extends State<ExerciceDetailsScreen> {
  late YoutubePlayerController _controller;

  Widget buidSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.green,
          fontSize: 22.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.youtubeLink!) != null
          ? widget.youtubeLink!
          : "https://www.youtube.com/watch?v=xLuILbm4cGg",
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
        isLive: false,
      ),
    );
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title!,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // YoutubePlayer(
            //   controller: _controller,
            //   showVideoProgressIndicator: true,
            //   onReady: () {
            //     print('Player is ready');
            //   },
            // ),
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                "assets/images/musculation/Gain-Muscle.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            buidSectionTitle(
              context,
              'Description',
            ),
            //
            // Text(widget.description!),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              children: [
                Text(
                  widget.description!,
                  style: TextStyle(fontFamily: 'Lato', fontSize: 17.0),
                ),
              ],
            ),
            //    ),
            buidSectionTitle(
              context,
              'Détails',
            ),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              children: [
                Text(
                  widget.details!,
                  style: TextStyle(fontFamily: 'Lato', fontSize: 17.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
    //     },
    //   );
  }
}
