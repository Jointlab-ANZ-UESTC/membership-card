import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:membership_card/network/client.dart';
import 'package:membership_card/pages/add_cards_with_camera.dart';
import 'package:membership_card/pages/add_cards_with_number.dart';
import 'package:membership_card/pages/card_info.dart';
import 'package:membership_card/pages/help.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

/// This is the All_Cards Page [AllCardsPage] which is the home of the App.
/// It shows all the cards users created and users can also add cards
/// in this page. Every Card is called [CardInfo].
/// One page showed four cards, every card has its information including
/// [CardInfo.cardId], [CardInfo.cardType], [CardInfo.remark]
/// When users click one card, it will go into the [CardInfoPage] which
/// contains all detailed information one card has.
/// Moreover, on the top-left users can click menu button to get [HelpPage]
/// which contains all the information about how this app works.
/// Add function is divided into two parts: [AddCardWithCameraPage] and
/// [AddCardWithNumberPage]. [AddCardWithCameraPage] uses camera API to read
/// cardNumber through bar code, while [AddCardWithNumberPage] needs user to
/// write the cardNumber on his/her own.
class AllCardsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AllCardsPageState();
  }
}

/// This is the state related to the [AllCardsPage]
/// It is the main state of the [AllCardsPage]
class AllCardsPageState extends State<AllCardsPage> {

  // These are the network variables for network connection
  Response res;
  Dio dio = initDio();

  // ignore: unused_element
  void _getCardInfo() async {
    //Todo: Lost API from backend
    res = await dio.get("/api/cards");
    Map<String, dynamic> json = jsonDecode(res.data.toString());
    Provider.of<CardCounter>(context).cardList = json["cardList"];
  }

  Widget _buildList(BuildContext context, int index) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: FlutterLogoDecoration(),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Consumer<CardCounter>(
          builder: (context, counter, child) => RaisedButton(
            onPressed: (){
              Navigator.of(context).pushNamed("/cardinfo",
                arguments: {
                  "cardInfo" : counter.cardList.elementAt(index)
                  //Todo: Start here
                }
              );
            },
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
//    _getCardInfo();

    return Scaffold(

      //Todo: AppBar may be updated in the future, but now we don't do this

      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 300 / 1920,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 24, bottom: 30),
              title: Text(
                "Card bag",
                style: TextStyle(
                  fontFamily: "msyh",
                  fontSize: 32.0,
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: Colors.white,
          ),
          Consumer<CardCounter>(
            builder: (context, counter, child) => SliverList(
              delegate: SliverChildBuilderDelegate(
                _buildList,
                childCount: 2,
              )
            ),
          )
        ],
      )
    );
  }
}