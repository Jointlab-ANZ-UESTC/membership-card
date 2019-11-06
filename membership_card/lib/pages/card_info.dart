import 'package:flutter/material.dart';

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
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

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
      body: Hero(
          tag: args["key"],
          child: SizedBox(
            height: 137.1,
            child: Container(
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/anz_card.png"),
              )),
              child: Text(
                "${args["cardType"]}\n" + "${args["cardId"]}",
                style: TextStyle(
                    color: Colors.white, fontFamily: "consolas", fontSize: 28.0),
              ),
            ),
          )),
    );
  }
}
