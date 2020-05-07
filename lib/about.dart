import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'strings.dart';

class AboutScreen extends StatelessWidget {
  final _sectionHeader =
      const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);
  final _sectionContent = const TextStyle(fontSize: 18.0);

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'WLrkT4F7tEc',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.aboutTitle),
      ),
      body: ListView(padding: EdgeInsets.all(16.0), children: <Widget>[
        Column(children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child:
                  Text(Strings.aboutPageParagraphOne, style: _sectionContent)),
          Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child:
                  Text(Strings.aboutPageParagraphTwo, style: _sectionContent)),
          Container(padding: EdgeInsets.symmetric(vertical: 8.0), child: Text(Strings.aboutPageParagraphThree, style: _sectionContent)),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: RaisedButton(
              onPressed: () {},
              color: Theme.of(context).primaryColor,
              child: Text(Strings.aboutPageDownloadLink.toUpperCase(),
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ]),
    );
  }
}
