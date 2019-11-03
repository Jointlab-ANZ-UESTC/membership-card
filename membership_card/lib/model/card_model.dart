import 'package:flutter/material.dart';
import 'package:membership_card/pages/all_cards.dart';


/// This is the class defining all the card info
/// It is generally used in [AllCardsState] and [AllCardsPage]
class CardInfo extends ChangeNotifier{
  static const String CARD_ID_JSON   = "cardId";
  static const String CARD_TYPE_JSON = "cardType";
  static const String REMARK_JSON    = "remark";

  String _cardId;
  String _cardType;
  String _remark;

  String get cardId => _cardId;
  String get cardType => _cardType;
  String get remark => _remark;

  CardInfo([this._cardId, this._remark, this._cardType]);

  CardInfo.fromJson(Map<String, dynamic> json) {
    this._cardId = json[CARD_ID_JSON];
    this._cardType = json[CARD_TYPE_JSON];
    this._remark = json[REMARK_JSON];
  }

  factory CardInfo.getJson(Map<String, dynamic> json) {
    return CardInfo(json[CARD_ID_JSON], json[REMARK_JSON], json[CARD_TYPE_JSON]);
  }

  Map<String, dynamic> toJson() => {
    CARD_ID_JSON   : cardId,
    CARD_TYPE_JSON : cardType,
    REMARK_JSON    : remark,
  };
}