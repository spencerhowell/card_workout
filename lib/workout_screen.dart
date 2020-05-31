import 'dart:async';

import 'package:cardworkout/exercises.dart';
import 'package:cardworkout/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cards.dart';
import 'strings.dart';
import 'workout_set.dart';

class WorkoutScreen extends StatefulWidget {
  WorkoutScreen({Key key, this.totalCards}) : super(key: key);
  final int totalCards;

  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  Deck _deck;
  Exercises _exercises;
  List<WorkoutSet> _sets;
  WorkoutSet _currentSet;

  Timer _restTimer;
  int _restCountdown = 120;

  @override
  void initState() {
    super.initState();
    _deck = Deck();
    _deck.shuffle();
    _sets = [];
    _exercises = Exercises();
    _setSet(_newSet());
  }

  @override
  void dispose() {
    _restTimer.cancel();
    super.dispose();
  }

  void _setSet(WorkoutSet set) {
    setState(() {
      _currentSet = set;
    });
  }

  WorkoutSet _newSet() {
    PlayingCard _newCard = _deck.drawCard();
    String _newExercise = _exercises.getExercise(_newCard);
    int _newSetNumber = _sets.length + 1;
    int _newGoalReps = _newCard.getCardValue() + 10;

    var newSet = WorkoutSet(
        card: _newCard,
        exercise: _newExercise,
        setNumber: _newSetNumber,
        goalReps: _newGoalReps);

    _sets.add(newSet);
    return newSet;
  }

  void _previousSet() {
    if (_currentSet.setNumber == 1) {
      return;
    }

    var previousSet = _sets.elementAt(_currentSet.setNumber - 2);
    //TODO throw error if previousSet is NULL

    _setSet(previousSet);
  }

  void _nextSet() {
    if (_currentSet.setNumber == widget.totalCards) {
      // End workout after last card
      //TODO connect to summary page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: Strings.appTitle)));
    } else if (_currentSet.setNumber == _sets.length) {
      _setSet(_newSet());
    } else {
      _setSet(_sets.elementAt(_currentSet.setNumber));
    }

    //TODO investigate starting timer outside of setState
    setState(() {
      if (_currentSet.card.cardRank == CardRank.ace) {
        startRestTimer();
      }
    });
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
                  titleTextStyle: Theme.of(context).textTheme.headline5,
                  contentTextStyle: Theme.of(context).textTheme.bodyText2,
                  title: Text(Strings.quitDialogTitle),
                  content: Text(Strings.quitDialogBody),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        Strings.quitDialogNegative,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.0),
                      ),
                    ),
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(
                        Strings.quitDialogPositive,
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
    if (_currentSet.card.cardRank == CardRank.ace) {
      var duration = Duration(
          minutes: (_restCountdown / Duration.secondsPerMinute).floor(),
          seconds: (_restCountdown % Duration.secondsPerMinute));
      return '${duration.toString()}';
    } else {
      return '${_currentSet.goalReps} ' + Strings.exerciseReps;
    }
  }

  Widget _cardPageView() {
    final controller = PageController(
      initialPage: 1,
    );

    return PageView(controller: controller, children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[500],
            width: 4,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.asset(
          _currentSet.card.getImagePath(),
          semanticLabel: _currentSet.card.toString(),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[500],
            width: 4,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.asset(
          _currentSet.card.getImagePath(),
          semanticLabel: _currentSet.card.toString(),
        ),
      ),
    ]);
  }

  Widget _cardDisplay() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      layoutBuilder: (Widget currentChild, List<Widget> previousChildren) {
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
        if (child.key == ValueKey(_currentSet.setNumber)) {
          return SlideTransition(child: child, position: outAnimation);
        } else {
          return SlideTransition(child: child, position: inAnimation);
        }
      },
      child: Container(
        key: ValueKey<int>(_currentSet.setNumber),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[500],
            width: 4,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.asset(
          _currentSet.card.getImagePath(),
          semanticLabel: _currentSet.card.toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).maybePop()),
            centerTitle: true,
            title: Text('${_currentSet.setNumber} / ${widget.totalCards}'),
          ),
          body: Center(
            child: Column(children: <Widget>[
              Spacer(flex: 2),
              _cardDisplay(),
              Spacer(flex: 2),
              Text(
                _currentSet.exercise,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              Text(
                _repsOrRest(),
                style: Theme.of(context).textTheme.headline4,
              ),
              Spacer(flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _previousSet,
                    child: Text(Strings.previousButtonText,
                        style: TextStyle(color: Colors.white)),
                  ),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _nextSet,
                    child: Text(Strings.nextButtonText,
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ]),
          )),
    );
  }
}
