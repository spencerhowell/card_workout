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

  String getRankString() {
    var rankString = "";

    switch (this.cardRank) {
      case CardRank.two:
        rankString = "2";
        break;
      case CardRank.three:
        rankString = "3";
        break;
      case CardRank.four:
        rankString = "4";
        break;
      case CardRank.five:
        rankString = "5";
        break;
      case CardRank.six:
        rankString = "6";
        break;
      case CardRank.seven:
        rankString = "7";
        break;
      case CardRank.eight:
        rankString = "8";
        break;
      case CardRank.nine:
        rankString = "9";
        break;
      case CardRank.ten:
        rankString = "10";
        break;
      case CardRank.jack:
        rankString = "jack";
        break;
      case CardRank.queen:
        rankString = "queen";
        break;
      case CardRank.king:
        rankString = "king";
        break;
      case CardRank.ace:
        rankString = "ace";
        break;
    }

    return rankString;
  }

  // Return two-character string consisting of rank and emoji
  String getAbbreviatedString() {
    var _shortString = "";

    switch(this.cardRank) {
      case CardRank.two:
        _shortString = "2";
        break;
      case CardRank.three:
        _shortString = "3";
        break;
      case CardRank.four:
        _shortString = "4";
        break;
      case CardRank.five:
         _shortString = "5";
        break;
      case CardRank.six:
         _shortString = "6";
        break;
      case CardRank.seven:
         _shortString = "7";
        break;
      case CardRank.eight:
         _shortString = "8";
        break;
      case CardRank.nine:
         _shortString = "9";
        break;
      case CardRank.ten:
         _shortString = "10";
        break;
      case CardRank.jack:
         _shortString = "J";
        break;
      case CardRank.queen:
         _shortString = "Q";
        break;
      case CardRank.king:
         _shortString = "K";
        break;
      case CardRank.ace:
        _shortString = "A";
        break;
    }

    _shortString += " ";

    switch (this.cardSuit) {
      case CardSuit.spades:
        _shortString += "\u2660";
        break;
      case CardSuit.hearts:
        _shortString += "\u2665";
        break;
      case CardSuit.diamonds:
        _shortString += "\u2666";
        break;
      case CardSuit.clubs:
        _shortString += "\u2663";
        break;
    }

    return _shortString;
  }

  String getSuitString() {
    return this.cardSuit.toString().split('.').last;
  }

  String toString() {
    return (this.cardRank.toString().split('.').last + ' of ' +
        this.cardSuit.toString().split('.').last);
  }

  String getImagePath() {
    return ('images/' + this.getRankString() + '_of_' + this.getSuitString() + '.png');
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
