import 'dart:collection';

import 'package:cardworkout/cards.dart';

class Exercises {
  ListQueue<String> push;
  ListQueue<String> pull;
  ListQueue<String> legs;
  ListQueue<String> isolation;
  Iterator pushIterator;
  Iterator pullIterator;
  Iterator legsIterator;
  Iterator isolationIterator;

  Exercises() {
    push = ListQueue<String>.from(["Push ups", "Pike push ups", "Standing press", "Lateral raises"]);
    pull = ListQueue<String>.from(["Pull ups", "Inverted / Dumbbell row", "Rear delt flyes", "Upright row"]);
    legs = ListQueue<String>.from(["Walking lunges", "Bulgarian split squat", "Single let hip thrust", "Nordic ham curl"]);
    isolation = ListQueue<String>.from(["Bicep curl", "Skullcrushers", "Bicycle crunch / Reverse crunch", "Standing calf raise"]);

    pushIterator = push.iterator;
    pullIterator = pull.iterator;
    legsIterator = legs.iterator;
    isolationIterator = isolation.iterator;
  }

  String getNextFromList(ListQueue<String> list, Iterator it) {
    if (!it.moveNext()) {
      it = list.iterator;
      it.moveNext();
    }
    return it.current;
  }

  String getExercise(PlayingCard card) {
    if (card.cardRank == CardRank.ace) {
      return "Rest 2 minutes";
    }

    switch(card.cardSuit) {
      case CardSuit.spades:
        return getNextFromList(push, pushIterator);
        break;
      case CardSuit.hearts:
        return getNextFromList(legs, legsIterator);
        break;
      case CardSuit.diamonds:
        return getNextFromList(isolation, isolationIterator);
        break;
      case CardSuit.clubs:
        return getNextFromList(pull, pullIterator);
        break;
    }

    //TODO make this an error message
    return "Oops";
  }
}