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
    _deck = Deck();
    _deck.shuffle();
    _currentCard = _deck.drawCard();
    _exercises = Exercises();
    _currentExercise = _exercises.getExercise(_currentCard);
    _currentReps = _currentCard.getCardValue() + 10;
    super.initState();
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
          title: Text('Workout in Progress'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  ('$_currentCardCount / ${widget.totalCards}'),
                  style: Theme.of(context).textTheme.subhead,
                ),
                Text(
                  '${_currentCard.toString()}',
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  _currentExercise,
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  '$_currentReps reps',
                  style: Theme.of(context).textTheme.display1,
                ),
                RaisedButton(
                  onPressed: _nextCard,
                  child: const Text("Next"),
                ),
              ]),
        ));
  }
}
