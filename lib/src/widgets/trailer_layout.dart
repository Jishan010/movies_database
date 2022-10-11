import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/trailer_model.dart';

class TrailerLayout extends StatelessWidget {
  final TrailerModel? data;

  const TrailerLayout({Key? key, required this.data}) : super(key: key);

  YoutubePlayerController getYouTubePlayerController(String? videoIdKey) {
    return YoutubePlayerController(
      initialVideoId: videoIdKey!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return data!.results.length > 1
        ? Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(5.0),
                height: 200.0,
                child: Stack(
                  children: [
                    const Icon(Icons.play_circle_filled),
                    YoutubePlayer(
                        progressIndicatorColor: Colors.amber,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.amber,
                          handleColor: Colors.amberAccent,
                        ),
                        controller:
                            getYouTubePlayerController(data?.results[0].key),
                        showVideoProgressIndicator: true,
                        thumbnail: Image.network(
                          "https://img.youtube.com/vi/${data?.results[0].key}/0.jpg",
                          fit: BoxFit.cover,
                        ),
                        onReady: () {
                          getYouTubePlayerController(data?.results[0].key)
                              .addListener(() {
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitUp,
                              DeviceOrientation.portraitDown,
                            ]);
                          });
                        })
                  ],
                ),
              ),
              Text(
                data?.results[0].name ?? "",
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
        : Container(
            child: const SizedBox(
              height: 200.0,
              child: Center(
                child: Text(
                  "No Trailer Available",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
  }
}
