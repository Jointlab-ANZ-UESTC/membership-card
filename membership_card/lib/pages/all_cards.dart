import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

/// This is the All_Cards Page which is the center of the App.
/// It shows all the cards users created and users can also add cards
/// in this page.
/// Moreover, users can get into the setting page which
/// users can set all the settings including username and passwords.
/// When users click one card, it will go into the Card Info Page which
/// contains all the card information
class AllCards extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AllCardsState();
  }
}

/// This is the state related to the All_Cards Widget
/// It is the main state of the All_Cards
class AllCardsState extends State<AllCards> {

  // These are the network variables for network connection
  Response res;
  Dio dio = Dio(
      BaseOptions(
        //Todo: Need to get Server URL first
          baseUrl: "***",
          connectTimeout: 3000,
          receiveTimeout: 3000,
          receiveDataWhenStatusError: false,
          sendTimeout: 3000
      )
  );

  void getCardInfo() async {
    //Todo: Lost API from backend
    res = await dio.get("/***");
    Map<String, dynamic> data = jsonDecode(res.data.toString());
    Provider.of<CardCounter>(context).cardList = data["cardList"];
  }

  @override
  Widget build(BuildContext context) {
//    getCardInfo();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Todo: Should go into the Add Card Page
//          Navigator.of(context).pushNamed("/add");
          Provider.of<CardCounter>(context).addCard(CardInfo(
            cardName: "My Card"
          ));
        },
        tooltip: "Add new card",
        backgroundColor: Colors.deepOrange,
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      ),

      appBar: AppBar(
        title: Text(
          "All Cards",
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.black
          ),
        ),

        backgroundColor: Colors.white,

        bottomOpacity: 0,

        actions: <Widget>[
          IconButton(
            onPressed: () {
              //Todo: Should go into Setting Page
              Navigator.of(context).pushNamed("/settings");
            },
            icon: Icon(Icons.settings),
            color: Colors.black,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //Todo: Should go into Search Page
              Navigator.of(context).pushNamed("/search");
            },
            color: Colors.black,
          )
        ],
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

              //Todo: It should be set by user
                crossAxisCount: 2,

                childAspectRatio: 1.44
            ),

            // it is defined by how many cards one user created
            itemCount: counter.cardList.length,

            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridTile(
                  footer: Container(
                    color: Colors.transparent,
                    child: Text(
                      counter.cardList.elementAt(index).cardName,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  header: PopupMenuButton(
                    //Todo: need to specify little menu button
                  ),
                  child: RaisedButton(
                      color: Colors.white70,
                      onPressed: (){
                        //Todo: Should go into the Card Info Page
                        Navigator.of(context).pushNamed(
                            "/cardinfo",
                            arguments: {
                              "index" : index
                            }
                        );
                      },
                      child: Text(
                        //Todo: It should be gotten from net
                        counter.cardList.elementAt(index).cardName,
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