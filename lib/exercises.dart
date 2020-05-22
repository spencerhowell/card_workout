import 'package:cardworkout/cards.dart';

import 'strings.dart';

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
    push = List<String>.from([
      Strings.pushUps,
      Strings.pikePushUps,
      Strings.standingPress,
      Strings.lateralRaises
    ]);
    pull = List<String>.from([
      Strings.pullUpVariation,
      Strings.rowVariation,
      Strings.rearDeltFlyes,
      Strings.uprightRow,
    ]);
    legs = List<String>.from([
      Strings.walkingLunges,
      Strings.bulgarianSplitSquat,
      Strings.singleLegHipThrust,
      Strings.nordicHamCurl,
    ]);
    isolation = List<String>.from([
      Strings.bicepCurl,
      Strings.skullcrushers,
      Strings.crunchVariation,
      Strings.standingCalfRaise,
    ]);

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
      return "Rest";
    }

    var exercise = "";

    switch (card.cardSuit) {
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
