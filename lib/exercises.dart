import 'dart:collection';

import 'package:cardworkout/cards.dart';

class Exercises {
  List<String> push;
  List<String> pull;
  List<String> legs;
  List<String> isolation;
  int pushIndex;
  int pullIndex;
  int legsIndex;
  int isolationIndex;

  Exercises() {
    push = List<String>.from(["Push ups", "Pike push ups", "Standing press", "Lateral raises"]);
    pull = List<String>.from(["Pull ups", "Inverted / Dumbbell row", "Rear delt flyes", "Upright row"]);
    legs = List<String>.from(["Walking lunges", "Bulgarian split squat", "Single let hip thrust", "Nordic ham curl"]);
    isolation = List<String>.from(["Bicep curl", "Skullcrushers", "Bicycle crunch / Reverse crunch", "Standing calf raise"]);

    // Start each index at the beginning of the list
    pushIndex = 0;
    pullIndex = 0;
    legsIndex = 0;
    isolationIndex = 0;
  }

  String getNextFromList(List<String> list, int i) {
    var next = list.elementAt(i % list.length);
    i++;
    return next;
  }

  String getExercise(PlayingCard card) {
    if (card.cardRank == CardRank.ace) {
      return "Rest 2 minutes";
    }

    var exercise = "";

    switch(card.cardSuit) {
      case CardSuit.spades:
        exercise = push.elementAt(pushIndex % push.length);
        pushIndex++;
        break;
      case CardSuit.hearts:
        exercise = legs.elementAt(legsIndex % legs.length);
        legsIndex++;
        break;
      case CardSuit.diamonds:
        exercise = isolation.elementAt(isolationIndex % isolation.length);
        isolationIndex++;
        break;
      case CardSuit.clubs:
        exercise = pull.elementAt(pullIndex % pull.length);
        pullIndex++;
        break;
    }

    //TODO make this an error message
    return exercise;
  }
}