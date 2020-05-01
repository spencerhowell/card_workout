import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

enum CardSuit {
  spades,
  hearts,
  diamonds,
  clubs,
}

enum CardRank {
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
  ace,
}

class PlayingCard {
  CardSuit cardSuit;
  CardRank cardRank;

  PlayingCard({
    @required this.cardSuit,
    @required this.cardRank,
});

  int getCardValue() {
    var _rank = this.cardRank;
    switch(_rank) {
      case CardRank.ace: // Aces are rest periods
        return 0;
        break;
      case CardRank.two:
        return 2;
        break;
      case CardRank.three:
        return 3;
        break;
      case CardRank.four:
        return 4;
        break;
      case CardRank.five:
        return 5;
        break;
      case CardRank.six:
        return 6;
        break;
      case CardRank.seven:
        return 7;
        break;
      case CardRank.eight:
        return 8;
        break;
      case CardRank.nine:
        return 9;
        break;
      default: // 10 and all face cards are worth 10
        return 10;
        break;
    }
  }

  String toString() {
    return (this.cardRank.toString().split('.').last + ' of ' +
        this.cardSuit.toString().split('.').last);
  }
}

class Deck {
  List<PlayingCard> cards;
  int _size = 52;


  Deck() {
    // Generate all 52 cards in list
    cards = new List();
    CardSuit.values.forEach((suit) {
      CardRank.values.forEach((rank) {
        cards.add(PlayingCard(
          cardRank: rank,
          cardSuit: suit,
        ));
      });
    });
  }

  void shuffle() {
    cards.shuffle();
  }

  PlayingCard drawCard() {
    return cards.removeAt(0);
  }
}
