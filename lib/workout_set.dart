import 'package:flutter/foundation.dart';

import 'cards.dart';

class WorkoutSet {
  PlayingCard card;
  String exercise;
  int setNumber;
  int goalReps;
  //TODO add timer

  WorkoutSet({
    @required this.card,
    @required this.exercise,
    @required this.setNumber,
    @required this.goalReps,
  });
}
