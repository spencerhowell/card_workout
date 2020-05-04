import 'package:cardworkout/exercises.dart';
import 'package:cardworkout/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cards.dart';

class WorkoutScreen extends StatefulWidget {
  WorkoutScreen({Key key, this.totalCards}) : super(key: key);
  final int totalCards;

  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _currentCardCount = 1;
  Deck _deck;
  PlayingCard _currentCard;
  Exercises _exercises;
  String _currentExercise;
  int _currentReps = 10;

  void initState() {
    super.initState();
    _deck = Deck();
    _deck.shuffle();
    _currentCard = _deck.drawCard();
    _exercises = Exercises();
    _currentExercise = _exercises.getExercise(_currentCard);
    _currentReps = _currentCard.getCardValue() + 10;
  }

  void _nextCard() {
    if (_currentCardCount == widget.totalCards) {
      //TODO connect to summary page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'CARD Workout')));
    } else {
      setState(() {
        _currentCardCount++;
        _currentCard = _deck.drawCard();
        _currentExercise = _exercises.getExercise(_currentCard);
        _currentReps = _currentCard.getCardValue() + 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('$_currentCardCount / ${widget.totalCards}'),
        ),
        body: Center(
          child: Column(
              children: <Widget>[
                Spacer(flex: 2),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[500],
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(_currentCard.getImagePath(), semanticLabel: _currentCard.toString(),),
                ),
                Spacer(flex: 2),
                Text(
                  _currentExercise,
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '$_currentReps reps',
                  style: Theme.of(context).textTheme.display1,
                ),
                Spacer(flex: 2),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _nextCard,
                  child: Text("NEXT", style: TextStyle(color: Colors.white)),
                ),
                Spacer(flex: 1),
              ]),
        ));
  }
}
