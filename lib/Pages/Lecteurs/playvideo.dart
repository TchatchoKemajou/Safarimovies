import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:safarimovie/Api/safariapi.dart';

class PlayVideoPage extends StatefulWidget {
  final Map<dynamic, dynamic> video;
  const PlayVideoPage({
    Key? key,
    required this.video
  }) : super(key: key);

  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  SafariApi safariapi = SafariApi();

  @override
  void dispose() {
    // TODO: implement dispose
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.video['video']);
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        safariapi.getFilm() + widget.video['video'].toString());
    _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
          aspectRatio: 16/9,
          autoPlay: true,
        ),
        betterPlayerDataSource: betterPlayerDataSource);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 16/9,
          child: BetterPlayer(
            controller: _betterPlayerController,
            // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            // //"assets/videos/stromae.mp4",
            // betterPlayerConfiguration: const BetterPlayerConfiguration(
            //     aspectRatio: 16/9,
            //     //autoPlay: true,
            //     //looping: true,
            // ),
          ),
        ),
      ),
    );
  }
}
