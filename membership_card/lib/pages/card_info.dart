import 'package:flutter/material.dart';
import '../model/card_model.dart';

/// This is the Card_Info Page showing one card's information.
/// It should include one card's all the information here.
class CardInfoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return CardInfoState();
  }
}

class CardInfoState extends State<CardInfoPage> {

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        //Todo: Add more UI for App bar from here
      ),
      //Todo: Add more UI about Card Info body from here
    );
  }
}

