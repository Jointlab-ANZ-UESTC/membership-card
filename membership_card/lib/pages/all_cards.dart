import 'package:flutter/material.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

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

  void getCardInfo() async {
    Dio dio = Dio(
        BaseOptions(
          //Todo: Need to get backend API first
          baseUrl: "",
          connectTimeout: 3000,
          receiveTimeout: 3000,
          receiveDataWhenStatusError: false,
          sendTimeout: 3000
        )
    );

    Response response = await dio.get("/");
    String data = response.data.toString();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Todo: Should go into the Add Card Page
          Navigator.of(context).pushNamed("/add");
        },
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

        bottom: AppBar(
          backgroundColor: Colors.white,
        ),

        actions: <Widget>[
          IconButton(
            onPressed: () {
              //Todo: Should go into Setting Page
            },
            icon: Icon(Icons.settings),
            color: Colors.black,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //Todo: Should go into Search Page
            },
            color: Colors.black,
          )
        ],
      ),

      body: Consumer<CardCounter>(
        builder:(context, counter, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

            //Todo: It should be set by user
              crossAxisCount: 2,

              childAspectRatio: 1.44
          ),

          // it is defined by how many cards one user created
          itemCount: counter.cardNumber,

          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridTile(
                  child: MaterialButton(
                    color: Colors.white70,
                    onPressed: (){
                      //Todo: Should go into the Card Info Page
                      Navigator.of(context).pushNamed("/cardinfo");
                    },
                    child: Text(
                      //Todo: It should be gotten from net
                      "Card " + (index + 1).toString(),
                      style: TextStyle(
                          fontSize: 20.0
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
              ),
            );
          },
        ),
      )
    );
  }
}