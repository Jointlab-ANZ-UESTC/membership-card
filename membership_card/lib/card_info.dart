import 'package:flutter/material.dart';
import 'model/card.dart';

/// This is the Card_Info Page showing one card's information
/// It should include one card's all the information here
class CardInfoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return CardInfoState();
  }
}

class CardInfoState extends State<CardInfoPage> {

  // This is the card info class for storing card info
  CardInfo _cardInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //Todo: Add more UI for App bar here
      ),
      //Todo: Add more UI about Card Info here
    );
  }
}

