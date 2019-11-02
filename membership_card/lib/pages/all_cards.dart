import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
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
/// cardName, cardStore, cardNotes
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
  Dio dio = Dio(
    // This is the base options for Dio client to connect to server
    BaseOptions(
      baseUrl: "129.204.110.90:8080",
      connectTimeout: 3000,
      receiveTimeout: 3000,
      receiveDataWhenStatusError: false,
      sendTimeout: 3000,
    ),
  );

  void _getCardInfo() async {
    //Todo: Lost API from backend
    res = await dio.get("/api/cards");
    Map<String, dynamic> data = jsonDecode(res.data.toString());
    Provider.of<CardCounter>(context).cardList = data["cardList"];
  }

  @override
  Widget build(BuildContext context) {
    _getCardInfo();

    return Scaffold(

      // App Bar lying on the top of the app
      appBar: AppBar(
        // PopupMenuButton is used for popping one menu on the click button
        leading: PopupMenuButton(
            offset: Offset(0, AppBar().preferredSize.height),
            itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text("Help"),
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                ),
                value: "help",)
            ],
            onSelected: (value) {
              switch (value) {
                case "help" :
                  Navigator.of(context).pushNamed("/help");
                  break;
              }
            },

            //Todo: Icon should be redesigned because of the Picture
            icon: Icon(Icons.account_balance, color: Colors.black, size: 32.0,)
        ),
        title: Text(
          "GoWallet",
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Colors.white,

        actions: <Widget>[
          Consumer<CardCounter>(
            builder: (context, counter, child) => PopupMenuButton(
              offset: Offset(0, AppBar().preferredSize.height),
              itemBuilder: (_) => <PopupMenuItem<String>> [
                PopupMenuItem(
                 child: ListTile(
                   leading: Icon(Icons.camera),
                   title: Text("camera"),
                   contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                  ),
                  value: "scan",
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.title),
                    title: Text("hand"),
                    contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                  ),
                  value: "number",
                )
              ],
              onSelected: (value) {
                switch (value) {
                  case "scan" :
                    Navigator.of(context).pushNamed("/add/camera");
                    break;
                  case "number" :
                    Navigator.of(context).pushNamed("/add/number");
                    break;
                }
               },
              icon: Icon(Icons.add, color: Colors.black, size: 32.0,),
            )
          ),
        ]
      ),

      body: Consumer<CardCounter>(
        builder:(context, counter, child) {
          return counter.cardList.length == 0 ?
          Center(
            child: Text(
              "Card Now Empty",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.grey
              )
            ),
          ) : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // It means how many cards one row can contain
              crossAxisCount: 1,

              // It means width : height
              childAspectRatio: 2.6,
            ),

            // it is defined by how many cards one user created
            itemCount: counter.cardList.length,

            // This is the builder for Card Widget building
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: GridTile(

                  //Todo: should be updated when UI gives pics
                  header: ListTile(
                    leading: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      //Todo: should be gotten from net
                      "Starbuck",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ),

                  footer: Container(
                    color: Colors.transparent,
                    child: Text(
                      counter.cardList.elementAt(index).cardId,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: () {
                      //Todo: Should go into the Card Info Page, and the args should be discussed
                      Navigator.of(context).pushNamed(
                        "/cardinfo",
                        arguments: {
                          "index" : index
                        },
                      );},
                    child: Text(
                      //Todo: It should be gotten from net
                      counter.cardList.elementAt(index).cardId,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              );
            },
          );}
      )
    );
  }
}