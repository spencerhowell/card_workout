import 'dart:ui';

import 'package:cardworkout/about.dart';
import 'package:cardworkout/setup.dart';
import 'package:cardworkout/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:cardworkout/strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(
          primaryColor: Colors.red[900],
          buttonTheme: ButtonThemeData(
            buttonColor: Theme.of(context).primaryColor,
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _cardCountController =
      TextEditingController.fromValue(TextEditingValue(text: "20"));

  void initState() {
    _cardCountController.addListener(() {
      final text = _cardCountController.text.toLowerCase();
      _cardCountController.value = _cardCountController.value.copyWith(
        text: text, // Set initial value
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  void dispose() {
    _cardCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appTitle),
      ),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(12.0),
              width: 200.0,
              height: 24.0,
              child: TextField(
                controller: _cardCountController,
                keyboardType: TextInputType.numberWithOptions(),
                textAlign: TextAlign.right,
                maxLength: 3,
                maxLengthEnforced: true,
                style: TextStyle(
                  fontSize: 40.0,
//                  height: 2.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    // Hide the counter below the text field
                    counterStyle: TextStyle(height: double.minPositive),
                    counterText: "",
                    suffixText: Strings.cardCountSuffix,
                    suffixStyle: TextStyle(fontSize: 20.0)),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WorkoutScreen(
                              totalCards: int.parse(_cardCountController.text),
                            )));
              }, // Generate deck and start workout
              color: Colors.red[900],
              child: Text(Strings.startWorkoutButtonText,
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            SizedBox(width: 1.0, height: 200.0),
            FlatButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutScreen()),
                  );
                },
                icon: Icon(Icons.info),
                label: Text(
                  Strings.aboutPageButtonText,
                  style: TextStyle(fontSize: 20),
                )),
            FlatButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SetupPage()),
                  );
                },
                icon: Icon(Icons.settings),
                label: Text(
                  Strings.setupPageButtonText,
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
