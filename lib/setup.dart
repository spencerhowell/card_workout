import 'package:flutter/material.dart';
import 'strings.dart';

class SetupPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.setupTitle)),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(Strings.legalNotice),
                ),
                ListTile(
                  title: Text(Strings.exerciseSetup),
                  subtitle: Text(Strings.exerciseSetupSubtitle),
                ),
                SwitchListTile(onChanged: (bool value) {  }, value: null,
                  
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}