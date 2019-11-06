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

  Widget _buildList(BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Consumer<CardCounter>(
              builder: (context, counter, child) => Hero(
                tag: counter.cardList.elementAt(index).cardKey,
                child: SizedBox(
                  height: 137.1,
                  child: GestureDetector(
                    onTap: () {
                        var cardInfo = counter.cardList.elementAt(index);
                        Navigator.of(context).pushNamed("/cardinfo", arguments: {
                          "cardId": cardInfo.cardId,
                          "cardType": cardInfo.cardType,
                          "remark": cardInfo.remark,
                          "key": cardInfo.cardKey,
                        });
                      },
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/anz_card.png"),
                            fit: BoxFit.fitHeight,
                          )
                      ),
                      child: Text(
                        "${counter.cardList.elementAt(index).cardType}\n" +
                            "${counter.cardList.elementAt(index).cardId}",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "consolas",
                            fontSize: 28.0),
                      ),
                    ),
                  )
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
//    _getCardInfo();

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
            icon: Icon(Icons.menu, color: Colors.black, size: 32.0,)
        ),
        title: Text(
          "GoWallet",
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 300 / 1920,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 6, bottom: 30),
                title: Text(
                  "Card bag",
                  style: TextStyle(
                    fontFamily: "msyh",
                    fontSize: 32.0,
                    color: Colors.black,
                  ),
                  value: "scan",
                ),
                PopupMenuDivider(),
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
                    Navigator.of(context).pushNamed("/addcamera");
                    break;
                  case "number" :
                    Navigator.of(context).pushNamed("/addnumber");
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
          if (counter.cardList.length == 0) {
            return Center(
              child: Text(
              "Card Now Empty",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.grey
              )
            ),
          );
          } else {
            return GridView.builder(
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

              var cardInfo = counter.cardList.elementAt(index);
              var cardKey = ObjectKey(cardInfo);

              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: GestureDetector(
                  onLongPress: (){
                    Navigator.of(context).push(
                      PopupDeleteRoute(args: <String, dynamic>{
                        "cardInfo" : cardInfo,
                      }),
                    );
                  },
                  child: GridTile(
                    key: cardKey,
                    //Todo: should be updated when UI gives pics
                    header: ListTile(
                      leading: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.deepOrange,
                      ),
                      title: Text(
                        //Todo: should be gotten from net
                        cardInfo.cardType,
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
                        cardInfo.remark == null?
                        "" : cardInfo.remark,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        //Todo: Should go into the Card Info Page, and the args should be discussed
                        Navigator.of(context).pushNamed(

                          "/cardinfo",
                          arguments: <String, dynamic>{
                            "cardId"   : cardInfo.cardId,
                            "cardType" : cardInfo.cardType,
                            "remark"   : cardInfo.remark,
                            "key"      : cardKey
                          },
                        );},
                      child: Text(
                        cardInfo.cardId,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              );
            },
          );
          }}
      )
    );
  }
}

class PopupDeleteRoute extends PopupRoute {

  Map<String, dynamic> args;

  PopupDeleteRoute({this.args});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Consumer<CardCounter>(
      builder: (context, counter, child) => AlertDialog(
        title: Text("Delete this card?"),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              counter.deleteCard(args["cardInfo"]);
              Navigator.of(context).pop();
            },
            child: Text(
              "Yes",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          FlatButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text(
              "No",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

}