import 'dart:async';

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

class _WorkoutScreenState extends State<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  int _currentCardCount = 1;
  Deck _deck;
  PlayingCard _currentCard;
  Exercises _exercises;
  String _currentExercise;
  int _currentReps = 10;
  Timer _restTimer;
  int _restCountdown = 120;

  @override
  void initState() {
    super.initState();
    _deck = Deck();
    _deck.shuffle();
    _currentCard = _deck.drawCard();
    _exercises = Exercises();
    _currentExercise = _exercises.getExercise(_currentCard);
    _currentReps = _currentCard.getCardValue() + 10;
  }

  @override
  void dispose() {
    _restTimer.cancel();
    super.dispose();
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
        if (_currentCard.cardRank == CardRank.ace) {
          startRestTimer();
        }
      });
    }
  }

  void startRestTimer() {
    _restCountdown = 120;
    _restTimer = Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) => setState(() {
              if (_restCountdown < 1) {
                timer.cancel();
              } else {
                _restCountdown -= 1;
              }
            }));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  titleTextStyle: Theme.of(context).textTheme.headline,
                  contentTextStyle: Theme.of(context).textTheme.body1,
                  title: Text('Quit workout?'),
                  content: Text('All progress will be lost'),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        'NO',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.0),
                      ),
                    ),
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(
                        'YES',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.0),
                      ),
                    ),
                  ],
                ))) ??
        false;
  }

  String _repsOrRest() {
    if (_currentCard.cardRank == CardRank.ace) {
      var duration = Duration(
          minutes: (_restCountdown / Duration.secondsPerMinute).floor(),
          seconds: (_restCountdown % Duration.secondsPerMinute));
      return '${duration.toString()}';
    } else {
      return '$_currentReps reps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('$_currentCardCount / ${widget.totalCards}'),
          ),
          body: Center(
            child: Column(children: <Widget>[
              Spacer(flex: 2),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                layoutBuilder:
                    (Widget currentChild, List<Widget> previousChildren) {
                  return Stack(
                    children: <Widget>[
                      if (currentChild != null) currentChild,
                      ...previousChildren,
                    ],
                    alignment: Alignment.center,
                  );
                },
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final inAnimation = MaterialPointArcTween(
                          begin: Offset(-2.0, 0.0), end: Offset(0.0, 0.0))
                      .animate(animation);
                  final outAnimation = MaterialPointArcTween(
                          begin: Offset(0.0, 0.0), end: Offset(0.0, 0.0))
                      .animate(animation);
                  if (child.key == ValueKey(_currentCardCount)) {
                    return SlideTransition(
                        child: child, position: outAnimation);
                  } else {
                    return SlideTransition(child: child, position: inAnimation);
                  }
                },
                child: Container(
                  key: ValueKey<int>(_currentCardCount),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[500],
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    _currentCard.getImagePath(),
                    semanticLabel: _currentCard.toString(),
                  ),
                ),
              ),
              Spacer(flex: 2),
              Text(
                _currentExercise,
                style: Theme.of(context).textTheme.display1,
                textAlign: TextAlign.center,
              ),
              Text(
                _repsOrRest(),
                style: Theme.of(context).textTheme.display1,
              ),
              Spacer(flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: Text("PREVIOUS", style: TextStyle(color: Colors.white)),
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _nextCard,
                    child: Text("NEXT", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Spacer(flex: 1),
            ]),
          )),
    );
  }
}
