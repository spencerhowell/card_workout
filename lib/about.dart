import 'package:flutter/material.dart';
import 'strings.dart';

class AboutScreen extends StatelessWidget {
  final _sectionHeader =
      const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);
  final _sectionContent = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.aboutTitle),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(Strings.aboutHeadline, style: _sectionHeader),
              Spacer(flex: 1),
              Text(Strings.aboutPageParagraphOne, style: _sectionContent),
              Spacer(flex: 1),
              Text(Strings.aboutPageParagraphTwo, style: _sectionContent),
              Spacer(flex: 1),
              Text(Strings.aboutPageParagraphThree, style: _sectionContent),
              Spacer(flex: 20),
            ]),
      ),
    );
  }
}
