import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Api/safariapi.dart';

import '../../Providers/videosProvider.dart';

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
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        (widget.video['rubrique'] == "Film" ? safariapi.getFilm().toString() : safariapi.getEpisode().toString()) + widget.video['video'].toString());
    _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
          aspectRatio: 16/9,
          autoPlay: true,
          allowedScreenSleep: false,
        ),
        betterPlayerDataSource: betterPlayerDataSource);
    super.initState();
    readVideo();

  }

  readVideo() async{
    final videoprovider = Provider.of<VideosProviders>(context, listen: false);
    await videoprovider.postVideoVue(widget.video["creator_id"]);
  }


  @override
  Widget build(BuildContext context) {
    print("voici le lien de la video" + safariapi.getFilm() + widget.video['video'].toString());
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
