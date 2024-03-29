import 'package:flutter/material.dart';
import 'package:membership_card/model/card_model.dart';

class CardCounter extends ChangeNotifier {

  List<CardInfo> _cardList = List<CardInfo>();

  set cardList(List<CardInfo> cardList) => this._cardList = cardList;
  List<CardInfo> get cardList => _cardList;

  void addCard(CardInfo cardInfo) {
    _cardList.add(cardInfo);
    notifyListeners();
  }

  void deleteCard(CardInfo cardInfo) {
    bool isRemoved = _cardList.remove(cardInfo);
    if (!isRemoved) throw new Exception("Card Remove failed");
  }
}