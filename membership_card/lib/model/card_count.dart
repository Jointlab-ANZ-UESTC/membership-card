import 'package:flutter/material.dart';

class CardCounter extends ChangeNotifier {

  int _cardNumber = 1;

  CardCounter([this._cardNumber]);

  set cardNumber(int cardNumber) => this._cardNumber = cardNumber;
  int get cardNumber => _cardNumber;

  void add() {
    _cardNumber++;
    notifyListeners();
  }

  void decrease() {
    _cardNumber--;
    assert(_cardNumber >= 0);
    notifyListeners();
  }

  void decreaseWithNumber(int deNumber) {
    _cardNumber -= deNumber;
    assert(_cardNumber >= 0);
    notifyListeners();
  }
}