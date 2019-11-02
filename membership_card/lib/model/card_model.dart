import 'package:flutter/material.dart';

/// This is the class defining all the card info
class CardInfo extends ChangeNotifier{
  //Todo: finishing all the card info here
  String cardName;

  CardInfo({this.cardName});

  //Todo: Need to fulfill JSON convert Constructor and function
  CardInfo.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson() => {
    "name" : cardName,
  };
}